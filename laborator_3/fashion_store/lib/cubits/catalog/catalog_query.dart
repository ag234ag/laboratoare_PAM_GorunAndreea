import '../../models/catalog_product.dart';
import '../../models/product.dart';

enum CatalogSort {
  relevance('Default order'),
  priceLowToHigh('Price: low to high'),
  priceHighToLow('Price: high to low'),
  nameAToZ('Name: A to Z');

  const CatalogSort(this.label);

  final String label;
}

class CatalogQuery {
  const CatalogQuery({
    this.search = '',
    this.collection,
    this.sort = CatalogSort.relevance,
    this.favoritesOnly = false,
  });

  final String search;
  final ProductCollection? collection;
  final CatalogSort sort;
  final bool favoritesOnly;

  bool get isFiltered =>
      search.trim().isNotEmpty || collection != null || favoritesOnly;

  CatalogQuery copyWith({
    String? search,
    ProductCollection? Function()? collection,
    CatalogSort? sort,
    bool? favoritesOnly,
  }) {
    return CatalogQuery(
      search: search ?? this.search,
      collection: collection == null ? this.collection : collection(),
      sort: sort ?? this.sort,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
    );
  }

  List<Product> apply(List<CatalogProduct> items, Set<String> favoriteIds) {
    final term = search.trim().toLowerCase();
    final filtered = [
      for (final item in items)
        if ((term.isEmpty || item.product.name.toLowerCase().contains(term)) &&
            (collection == null || item.collections.contains(collection)) &&
            (!favoritesOnly || favoriteIds.contains(item.product.id)))
          item.product,
    ];

    switch (sort) {
      case CatalogSort.relevance:
        break;
      case CatalogSort.priceLowToHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
      case CatalogSort.priceHighToLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
      case CatalogSort.nameAToZ:
        filtered.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
    }
    return filtered;
  }
}
