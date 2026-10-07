import 'package:bloc_test/bloc_test.dart';
import 'package:fashion_store/cubits/catalog/catalog_cubit.dart';
import 'package:fashion_store/cubits/catalog/catalog_query.dart';
import 'package:fashion_store/cubits/catalog/catalog_state.dart';
import 'package:fashion_store/data/store_repository.dart';
import 'package:fashion_store/models/catalog_product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/fake_store_repository.dart';

List<String> _names(CatalogState state) =>
    (state as CatalogSuccess).products.map((p) => p.name).toList();

void main() {
  blocTest<CatalogCubit, CatalogState>(
    'load emits Loading then Success with every product',
    build: () => CatalogCubit(FakeStoreRepository()),
    act: (cubit) => cubit.load(),
    expect: () => [
      isA<CatalogLoading>(),
      isA<CatalogSuccess>().having((s) => s.products.length, 'count', 4),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'load emits Error when the repository fails',
    build: () => CatalogCubit(
      FakeStoreRepository(error: const StoreDataException('broken')),
    ),
    act: (cubit) => cubit.load(),
    expect: () => [
      isA<CatalogLoading>(),
      isA<CatalogError>().having((s) => s.message, 'message', 'broken'),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'load emits Empty (not filtered) when the catalog has no products',
    build: () => CatalogCubit(FakeStoreRepository(catalog: const [])),
    act: (cubit) => cubit.load(),
    expect: () => [
      isA<CatalogLoading>(),
      isA<CatalogEmpty>().having((s) => s.query.isFiltered, 'filtered', false),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'search is case-insensitive and trims whitespace',
    build: () => CatalogCubit(FakeStoreRepository()),
    act: (cubit) async {
      await cubit.load();
      cubit.search('  HOODIE ');
    },
    skip: 2,
    expect: () => [
      predicate<CatalogState>((s) => _names(s).join() == 'White Hoodie'),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'search without matches emits filtered Empty',
    build: () => CatalogCubit(FakeStoreRepository()),
    act: (cubit) async {
      await cubit.load();
      cubit.search('jacket');
    },
    skip: 2,
    expect: () => [
      isA<CatalogEmpty>().having((s) => s.query.isFiltered, 'filtered', true),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'collection filter keeps only tagged products',
    build: () => CatalogCubit(FakeStoreRepository()),
    act: (cubit) async {
      await cubit.load();
      cubit.filterByCollection(ProductCollection.featured);
    },
    skip: 2,
    expect: () => [
      predicate<CatalogState>(
        (s) =>
            _names(s)
                .toSet()
                .containsAll(['Turtleneck Sweater', 'Long Sleeve Dress']) &&
            _names(s).length == 2,
      ),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'sorting by price and name',
    build: () => CatalogCubit(FakeStoreRepository()),
    act: (cubit) async {
      await cubit.load();
      cubit
        ..sortBy(CatalogSort.priceLowToHigh)
        ..sortBy(CatalogSort.priceHighToLow)
        ..sortBy(CatalogSort.nameAToZ);
    },
    skip: 2,
    expect: () => [
      predicate<CatalogState>((s) => _names(s).first == 'White Hoodie'),
      predicate<CatalogState>((s) => _names(s).first == 'Gym Crop Top'),
      predicate<CatalogState>(
        (s) =>
            _names(s).join(',') ==
            'Gym Crop Top,Long Sleeve Dress,Turtleneck Sweater,White Hoodie',
      ),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'favorites-only follows favorite updates',
    build: () => CatalogCubit(FakeStoreRepository(), favoriteIds: {'p2'}),
    act: (cubit) async {
      await cubit.load();
      cubit
        ..toggleFavoritesOnly()
        ..updateFavorites({})
        ..updateFavorites({'p1', 'p4'});
    },
    skip: 2,
    expect: () => [
      predicate<CatalogState>((s) => _names(s).join() == 'Long Sleeve Dress'),
      isA<CatalogEmpty>(),
      predicate<CatalogState>((s) => _names(s).length == 2),
    ],
  );

  blocTest<CatalogCubit, CatalogState>(
    'initial query is applied on load and clearFilters keeps the sort',
    build: () => CatalogCubit(
      FakeStoreRepository(),
      initialQuery: const CatalogQuery(
        collection: ProductCollection.recommended,
        sort: CatalogSort.priceHighToLow,
      ),
    ),
    act: (cubit) async {
      await cubit.load();
      cubit.clearFilters();
    },
    expect: () => [
      isA<CatalogLoading>(),
      predicate<CatalogState>((s) => _names(s).join() == 'White Hoodie'),
      predicate<CatalogState>(
        (s) =>
            _names(s).length == 4 &&
            (s as CatalogSuccess).query.sort == CatalogSort.priceHighToLow,
      ),
    ],
  );
}
