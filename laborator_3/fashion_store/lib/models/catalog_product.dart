import 'product.dart';

enum ProductCollection {
  featured('Featured'),
  recommended('Recommended'),
  similar('Similar');

  const ProductCollection(this.label);

  final String label;
}

class CatalogProduct {
  const CatalogProduct({required this.product, required this.collections});

  final Product product;
  final Set<ProductCollection> collections;
}
