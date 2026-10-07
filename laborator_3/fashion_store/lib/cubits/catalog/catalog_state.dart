import '../../models/product.dart';
import 'catalog_query.dart';

sealed class CatalogState {
  const CatalogState();
}

final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

final class CatalogError extends CatalogState {
  const CatalogError(this.message);

  final String message;
}

sealed class CatalogReady extends CatalogState {
  const CatalogReady(this.query);

  final CatalogQuery query;
}

final class CatalogSuccess extends CatalogReady {
  const CatalogSuccess(super.query, this.products);

  final List<Product> products;
}

final class CatalogEmpty extends CatalogReady {
  const CatalogEmpty(super.query);
}
