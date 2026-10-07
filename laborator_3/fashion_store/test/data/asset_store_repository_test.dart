import 'dart:convert';
import 'dart:io';

import 'package:fashion_store/data/asset_store_repository.dart';
import 'package:fashion_store/data/store_repository.dart';
import 'package:fashion_store/models/catalog_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _StringBundle extends CachingAssetBundle {
  _StringBundle(this.content);

  final String? content;

  @override
  Future<ByteData> load(String key) async {
    final value = content;
    if (value == null) throw FlutterError('Unable to load asset: $key');
    return ByteData.sublistView(utf8.encode(value));
  }
}

Map<String, dynamic> _rawJson() =>
    jsonDecode(File('assets/data/gem_store.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AssetStoreRepository repository() =>
      AssetStoreRepository(latency: Duration.zero);

  group('oracle: catalog vs raw JSON', () {
    test(
      'every product entry in the JSON lands in the catalog exactly once',
      () async {
        final raw = _rawJson();
        final home = raw['homePage'] as Map<String, dynamic>;
        final page =
            (raw['productPage'] as Map<String, dynamic>)['product']
                as Map<String, dynamic>;

        final sources = <String, List<Map<String, dynamic>>>{
          'featureProducts': (home['featureProducts'] as List).cast(),
          'recommended': (home['recommended'] as List).cast(),
          'productPage.product': [page],
          'similarProducts': (page['similarProducts'] as List).cast(),
        };
        final rawEntries = sources.values.expand((e) => e).toList();
        final firstById = <String, Map<String, dynamic>>{};
        for (final entry in rawEntries) {
          firstById.putIfAbsent(entry['id'] as String, () => entry);
        }
        final duplicates = rawEntries.length - firstById.length;

        final catalog = await repository().fetchCatalog();
        final catalogById = {for (final c in catalog) c.product.id: c.product};

        expect(
          catalog.length,
          catalogById.length,
          reason: 'catalog has duplicate ids',
        );
        expect(
          catalog.length + duplicates,
          rawEntries.length,
          reason: 'processed + merged duplicates must equal raw total',
        );
        expect(catalogById.keys.toSet(), firstById.keys.toSet());

        for (final MapEntry(key: id, value: entry) in firstById.entries) {
          final product = catalogById[id]!;
          expect(product.name, entry['name'], reason: id);
          expect(product.price, (entry['price'] as num).toDouble(), reason: id);
          expect(
            product.imageUrl,
            entry['imageUrl'] ?? entry['mainImageUrl'],
            reason: id,
          );
        }
      },
    );

    test(
      'collection tags match the JSON section each product came from',
      () async {
        final raw = _rawJson();
        final home = raw['homePage'] as Map<String, dynamic>;
        final page =
            (raw['productPage'] as Map<String, dynamic>)['product']
                as Map<String, dynamic>;
        Set<String> ids(List list) => {
          for (final p in list) (p as Map)['id'] as String,
        };

        final catalog = await repository().fetchCatalog();
        Set<String> tagged(ProductCollection c) => {
          for (final p in catalog)
            if (p.collections.contains(c)) p.product.id,
        };

        expect(
          tagged(ProductCollection.featured),
          ids(home['featureProducts'] as List),
        );
        expect(
          tagged(ProductCollection.recommended),
          ids(home['recommended'] as List),
        );
        expect(
          tagged(ProductCollection.similar),
          ids(page['similarProducts'] as List),
        );
      },
    );

    test('home and details reflect the JSON values', () async {
      final raw = _rawJson();
      final home = raw['homePage'] as Map<String, dynamic>;
      final page =
          (raw['productPage'] as Map<String, dynamic>)['product']
              as Map<String, dynamic>;
      final repo = repository();

      final data = await repo.fetchHome();
      expect(data.storeName, home['storeName']);
      expect(
        data.categories.map((c) => c.id),
        (home['categories'] as List).map((c) => c['id']),
      );
      expect(
        data.topCollections.map((p) => p.title),
        (home['topCollections'] as List).map((p) => p['title']),
      );

      final details = await repo.fetchProductDetails(page['id'] as String);
      expect(
        details.reviews.map((r) => r.author),
        (page['reviews'] as List).map((r) => r['author']),
      );
      expect(
        details.ratingBreakdown.map((r) => r.percentage),
        (page['ratingBreakdown'] as List).map(
          (r) => (r['percentage'] as num).toDouble(),
        ),
      );
      expect(details.selectedSize, page['selectedSize']);
      expect(details.galleryImageUrls.first, page['mainImageUrl']);
      expect(
        details.galleryImageUrls,
        containsAll((page['galleryImageUrls'] as List).cast<String>()),
      );
      for (final size in (page['availableSizes'] as List).cast<String>()) {
        expect(
          details.isSizeAvailable(size),
          (page['sizeAvailability'] as Map)[size],
          reason: size,
        );
      }

      final favorites = await repo.fetchFavoriteIds();
      expect(
        favorites.contains(page['id']),
        (page['actions'] as Map)['isFavorite'],
      );
    });
  });

  group('AssetStoreRepository', () {
    test(
      'returns basic details for catalog products without a product page',
      () async {
        final details = await repository().fetchProductDetails('p001');
        expect(details.product.name, 'Turtleneck Sweater');
        expect(details.reviews, isEmpty);
      },
    );

    test('throws ProductNotFoundException for unknown ids', () {
      expect(
        repository().fetchProductDetails('missing'),
        throwsA(isA<ProductNotFoundException>()),
      );
    });

    test('invalid JSON becomes a StoreDataException', () {
      final repo = AssetStoreRepository(
        bundle: _StringBundle('a{"homePage": {}}'),
        latency: Duration.zero,
      );
      expect(repo.fetchHome(), throwsA(isA<StoreDataException>()));
    });

    test('unexpected structure becomes a StoreDataException', () {
      final repo = AssetStoreRepository(
        bundle: _StringBundle('{"homePage": []}'),
        latency: Duration.zero,
      );
      expect(repo.fetchHome(), throwsA(isA<StoreDataException>()));
    });

    test('missing file becomes a StoreDataException', () {
      final repo = AssetStoreRepository(
        bundle: _StringBundle(null),
        latency: Duration.zero,
      );
      expect(repo.fetchHome(), throwsA(isA<StoreDataException>()));
    });

    test('a failed load is retried instead of cached', () async {
      final bundle = _RecoveringBundle();
      final repo = AssetStoreRepository(bundle: bundle, latency: Duration.zero);

      await expectLater(repo.fetchHome(), throwsA(isA<StoreDataException>()));
      bundle.content = File('assets/data/gem_store.json').readAsStringSync();
      expect((await repo.fetchHome()).storeName, 'GemStore');
    });
  });
}

class _RecoveringBundle extends AssetBundle {
  String content = 'not json';

  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(utf8.encode(content));

  @override
  Future<String> loadString(String key, {bool cache = true}) async => content;

  @override
  Future<T> loadStructuredData<T>(
    String key,
    Future<T> Function(String) parser,
  ) => parser(content);

  @override
  void evict(String key) {}
}
