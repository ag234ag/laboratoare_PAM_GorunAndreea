import '../models/catalog_product.dart';
import '../models/home_data.dart';
import '../models/product_details.dart';

abstract interface class StoreRepository {
  Future<HomeData> fetchHome();

  Future<List<CatalogProduct>> fetchCatalog();

  Future<ProductDetails> fetchProductDetails(String productId);

  Future<Set<String>> fetchFavoriteIds();
}

class StoreDataException implements Exception {
  const StoreDataException(this.message);

  final String message;

  @override
  String toString() => 'StoreDataException: $message';
}

class ProductNotFoundException extends StoreDataException {
  const ProductNotFoundException(this.productId)
    : super('Product "$productId" was not found.');

  final String productId;
}
