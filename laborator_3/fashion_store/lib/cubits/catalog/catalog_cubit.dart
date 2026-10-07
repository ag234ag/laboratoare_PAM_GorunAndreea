import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/store_repository.dart';
import '../../models/catalog_product.dart';
import '../error_message.dart';
import 'catalog_query.dart';
import 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(
    this._repository, {
    CatalogQuery initialQuery = const CatalogQuery(),
    Set<String> favoriteIds = const {},
  }) : _query = initialQuery,
       _favoriteIds = Set.unmodifiable(favoriteIds),
       super(const CatalogLoading());

  final StoreRepository _repository;

  CatalogQuery _query;
  Set<String> _favoriteIds;
  List<CatalogProduct> _items = const [];

  CatalogQuery get query => _query;

  Future<void> load() async {
    emit(const CatalogLoading());
    try {
      _items = await _repository.fetchCatalog();
      if (!isClosed) _emitVisible();
    } catch (error) {
      if (!isClosed) emit(CatalogError(errorMessage(error)));
    }
  }

  void search(String text) => _update(_query.copyWith(search: text));

  void filterByCollection(ProductCollection? collection) =>
      _update(_query.copyWith(collection: () => collection));

  void sortBy(CatalogSort sort) => _update(_query.copyWith(sort: sort));

  void toggleFavoritesOnly() =>
      _update(_query.copyWith(favoritesOnly: !_query.favoritesOnly));

  void clearFilters() => _update(CatalogQuery(sort: _query.sort));

  void updateFavorites(Set<String> favoriteIds) {
    _favoriteIds = favoriteIds;
    if (state is CatalogReady) _emitVisible();
  }

  void _update(CatalogQuery query) {
    _query = query;
    if (state is CatalogReady) _emitVisible();
  }

  void _emitVisible() {
    final products = _query.apply(_items, _favoriteIds);
    emit(
      products.isEmpty
          ? CatalogEmpty(_query)
          : CatalogSuccess(_query, products),
    );
  }
}
