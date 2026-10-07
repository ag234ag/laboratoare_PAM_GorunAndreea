import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/catalog_product.dart';
import '../models/home_data.dart';
import '../models/json_utils.dart';
import '../models/product.dart';
import '../models/product_details.dart';
import 'app_assets.dart';
import 'store_repository.dart';

class AssetStoreRepository implements StoreRepository {
  AssetStoreRepository({
    AssetBundle? bundle,
    this.assetPath = AppData.store,
    this.latency = const Duration(milliseconds: 700),
  }) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  final String assetPath;
  final Duration latency;

  Future<_StoreSnapshot>? _snapshot;

  @override
  Future<HomeData> fetchHome() async => (await _load()).home;

  @override
  Future<List<CatalogProduct>> fetchCatalog() async => (await _load()).catalog;

  @override
  Future<ProductDetails> fetchProductDetails(String productId) async {
    final snapshot = await _load();
    if (snapshot.details.product.id == productId) return snapshot.details;

    for (final item in snapshot.catalog) {
      if (item.product.id == productId) {
        return ProductDetails.basic(item.product);
      }
    }
    throw ProductNotFoundException(productId);
  }

  @override
  Future<Set<String>> fetchFavoriteIds() async {
    final details = (await _load()).details;
    return {if (details.actions.isFavorite) details.product.id};
  }

  Future<_StoreSnapshot> _load() async {
    final pending = _snapshot ??= _read();
    try {
      return await pending;
    } catch (_) {
      _snapshot = null;
      rethrow;
    }
  }

  Future<_StoreSnapshot> _read() async {
    await Future<void>.delayed(latency);

    final String raw;
    try {
      raw = await _bundle.loadString(assetPath);
    } on FlutterError {
      throw StoreDataException('Store data file "$assetPath" is missing.');
    }

    try {
      return _StoreSnapshot.fromJson(jsonDecode(raw) as JsonMap);
    } on FormatException catch (error) {
      throw StoreDataException(
        'Store data is not valid JSON: ${error.message}',
      );
    } on TypeError {
      throw const StoreDataException('Store data has an unexpected structure.');
    }
  }
}

class _StoreSnapshot {
  _StoreSnapshot({required this.home, required this.details})
    : catalog = _buildCatalog(home, details);

  factory _StoreSnapshot.fromJson(JsonMap json) {
    final productPage = json['productPage'] as JsonMap;
    return _StoreSnapshot(
      home: HomeData.fromJson(json['homePage'] as JsonMap),
      details: ProductDetails.fromJson(productPage['product'] as JsonMap),
    );
  }

  final HomeData home;
  final ProductDetails details;
  final List<CatalogProduct> catalog;

  static List<CatalogProduct> _buildCatalog(
    HomeData home,
    ProductDetails details,
  ) {
    final products = <String, Product>{};
    final collections = <String, Set<ProductCollection>>{};

    void add(Product product, ProductCollection? collection) {
      products.putIfAbsent(product.id, () => product);
      final tags = collections.putIfAbsent(product.id, () => {});
      if (collection != null) tags.add(collection);
    }

    for (final product in home.featureProducts) {
      add(product, ProductCollection.featured);
    }
    for (final product in home.recommended) {
      add(product, ProductCollection.recommended);
    }
    add(details.product, null);
    for (final product in details.similarProducts) {
      add(product, ProductCollection.similar);
    }

    return [
      for (final entry in products.entries)
        CatalogProduct(
          product: entry.value,
          collections: Set.unmodifiable(collections[entry.key]!),
        ),
    ];
  }
}
