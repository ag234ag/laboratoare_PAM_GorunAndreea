import 'dart:ui' show Color;

import 'package:fashion_store/data/store_repository.dart';
import 'package:fashion_store/models/catalog_product.dart';
import 'package:fashion_store/models/hero_banner.dart';
import 'package:fashion_store/models/home_data.dart';
import 'package:fashion_store/models/product.dart';
import 'package:fashion_store/models/product_details.dart';
import 'package:fashion_store/models/promo.dart';
import 'package:fashion_store/models/review.dart';
import 'package:fashion_store/models/shop_category.dart';

Product product(String id, String name, double price) => Product(
  id: id,
  name: name,
  price: price,
  currency: 'USD',
  imageUrl: 'https://example.com/$id.png',
);

final sweater = product('p1', 'Turtleneck Sweater', 39.99);
final dress = product('p2', 'Long Sleeve Dress', 45);
final hoodie = product('p3', 'White Hoodie', 29);
final top = product('p4', 'Gym Crop Top', 52);

final sampleCatalog = [
  CatalogProduct(product: sweater, collections: {ProductCollection.featured}),
  CatalogProduct(product: dress, collections: {ProductCollection.featured}),
  CatalogProduct(product: hoodie, collections: {ProductCollection.recommended}),
  CatalogProduct(product: top, collections: {ProductCollection.similar}),
];

HomeData sampleHome({List<Product>? featured, List<Product>? recommended}) {
  return HomeData(
    storeName: 'GemStore',
    categories: const [
      ShopCategory(
        id: 'women',
        name: 'Women',
        iconUrl: 'https://example.com/w.svg',
        selected: true,
      ),
      ShopCategory(
        id: 'men',
        name: 'Men',
        iconUrl: 'https://example.com/m.svg',
        selected: false,
      ),
    ],
    heroBanner: const HeroBannerData(
      id: 'hero',
      title: 'Autumn Collection 2021',
      imageUrl: 'https://example.com/hero.png',
      action: 'View collection',
      slides: 3,
      activeSlide: 0,
    ),
    featureProducts: featured ?? [sweater, dress],
    newCollection: const Promo(
      label: 'NEW COLLECTION',
      title: 'HANG OUT & PARTY',
      imageUrl: 'https://example.com/new.png',
    ),
    recommended: recommended ?? [hoodie],
    topCollections: const [],
    categoryPromos: const [],
  );
}

ProductDetails sampleDetails() {
  return ProductDetails(
    product: sweater,
    galleryImageUrls: [sweater.imageUrl],
    rating: 4.5,
    ratingCount: 10,
    reviewCount: 2,
    description: 'Warm and soft.',
    descriptionExpanded: false,
    availableColors: const [
      ProductColor(id: 'black', name: 'Black', color: Color(0xFF000000)),
      ProductColor(id: 'beige', name: 'Beige', color: Color(0xFFE9C5AC)),
    ],
    selectedColorId: 'beige',
    availableSizes: const ['S', 'M', 'L'],
    selectedSize: 'L',
    sizeAvailability: const {'S': false, 'M': true, 'L': true},
    ratingBreakdown: const [RatingShare(stars: 5, percentage: 100)],
    reviews: const [
      Review(
        id: 'r1',
        author: 'Ana',
        avatarUrl: 'https://example.com/a.png',
        rating: 5,
        createdAtLabel: '1m ago',
        text: 'Great',
      ),
    ],
    similarProducts: [dress],
    actions: ProductActions.defaults,
  );
}

class FakeStoreRepository implements StoreRepository {
  FakeStoreRepository({
    HomeData? home,
    List<CatalogProduct>? catalog,
    ProductDetails? details,
    this.favoriteIds = const {},
    this.error,
  }) : home = home ?? sampleHome(),
       catalog = catalog ?? sampleCatalog,
       details = details ?? sampleDetails();

  final HomeData home;
  final List<CatalogProduct> catalog;
  final ProductDetails details;
  final Set<String> favoriteIds;
  Object? error;

  Future<T> _respond<T>(T value) async {
    final failure = error;
    if (failure != null) throw failure;
    return value;
  }

  @override
  Future<HomeData> fetchHome() => _respond(home);

  @override
  Future<List<CatalogProduct>> fetchCatalog() => _respond(catalog);

  @override
  Future<Set<String>> fetchFavoriteIds() => _respond(favoriteIds);

  @override
  Future<ProductDetails> fetchProductDetails(String productId) async {
    if (productId == details.product.id) return _respond(details);
    for (final item in await _respond(catalog)) {
      if (item.product.id == productId) {
        return ProductDetails.basic(item.product);
      }
    }
    throw ProductNotFoundException(productId);
  }
}
