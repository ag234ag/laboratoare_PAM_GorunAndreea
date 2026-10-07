import 'hero_banner.dart';
import 'json_utils.dart';
import 'product.dart';
import 'promo.dart';
import 'shop_category.dart';

class HomeData {
  const HomeData({
    required this.storeName,
    required this.categories,
    required this.heroBanner,
    required this.featureProducts,
    required this.newCollection,
    required this.recommended,
    required this.topCollections,
    required this.categoryPromos,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      storeName: json['storeName'] as String,
      categories: parseList(json['categories'], ShopCategory.fromJson),
      heroBanner: HeroBannerData.fromJson(
        json['heroBanner'] as Map<String, dynamic>,
      ),
      featureProducts: parseList(json['featureProducts'], Product.fromJson),
      newCollection: Promo.fromJson(
        json['newCollection'] as Map<String, dynamic>,
      ),
      recommended: parseList(json['recommended'], Product.fromJson),
      topCollections: parseList(json['topCollections'], Promo.fromJson),
      categoryPromos: parseList(json['categoryPromos'], CategoryPromo.fromJson),
    );
  }

  final String storeName;
  final List<ShopCategory> categories;
  final HeroBannerData heroBanner;
  final List<Product> featureProducts;
  final Promo newCollection;
  final List<Product> recommended;
  final List<Promo> topCollections;
  final List<CategoryPromo> categoryPromos;

  bool get hasProducts => featureProducts.isNotEmpty || recommended.isNotEmpty;

  String? get initialCategoryId {
    for (final category in categories) {
      if (category.selected) return category.id;
    }
    return categories.isEmpty ? null : categories.first.id;
  }
}
