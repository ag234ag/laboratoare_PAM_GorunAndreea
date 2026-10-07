import 'dart:ui' show Color;

import 'json_utils.dart';
import 'product.dart';
import 'review.dart';

class ProductColor {
  const ProductColor({
    required this.id,
    required this.name,
    required this.color,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    final hex = (json['value'] as String).replaceFirst('#', '');
    return ProductColor(
      id: json['id'] as String,
      name: json['name'] as String,
      color: Color(int.parse('FF$hex', radix: 16)),
    );
  }

  final String id;
  final String name;
  final Color color;
}

class RatingShare {
  const RatingShare({required this.stars, required this.percentage});

  factory RatingShare.fromJson(Map<String, dynamic> json) {
    return RatingShare(
      stars: json['stars'] as int,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  final int stars;
  final double percentage;
}

class ProductActions {
  const ProductActions({
    required this.isFavorite,
    required this.canAddToCart,
    required this.addToCartLabel,
  });

  factory ProductActions.fromJson(Map<String, dynamic> json) {
    return ProductActions(
      isFavorite: json['isFavorite'] as bool? ?? false,
      canAddToCart: json['canAddToCart'] as bool? ?? true,
      addToCartLabel:
          json['addToCartLabel'] as String? ?? defaults.addToCartLabel,
    );
  }

  static const defaults = ProductActions(
    isFavorite: false,
    canAddToCart: true,
    addToCartLabel: 'Add To Cart',
  );

  final bool isFavorite;
  final bool canAddToCart;
  final String addToCartLabel;
}

class ProductDetails {
  const ProductDetails({
    required this.product,
    required this.galleryImageUrls,
    required this.rating,
    required this.ratingCount,
    required this.reviewCount,
    required this.description,
    required this.descriptionExpanded,
    required this.availableColors,
    required this.selectedColorId,
    required this.availableSizes,
    required this.selectedSize,
    required this.sizeAvailability,
    required this.ratingBreakdown,
    required this.reviews,
    required this.similarProducts,
    required this.actions,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    final product = Product.fromJson(json);
    final gallery = (json['galleryImageUrls'] as List<dynamic>? ?? const [])
        .cast<String>();

    return ProductDetails(
      product: product,
      galleryImageUrls: [
        product.imageUrl,
        ...gallery.where((url) => url != product.imageUrl),
      ],
      rating: (json['rating'] as num? ?? 0).toDouble(),
      ratingCount: json['ratingCount'] as int? ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      descriptionExpanded: json['descriptionExpanded'] as bool? ?? false,
      availableColors: parseList(
        json['availableColors'],
        ProductColor.fromJson,
      ),
      selectedColorId: json['selectedColor'] as String?,
      availableSizes: (json['availableSizes'] as List<dynamic>? ?? const [])
          .cast<String>(),
      selectedSize: json['selectedSize'] as String?,
      sizeAvailability:
          (json['sizeAvailability'] as Map<String, dynamic>? ?? const {}).map(
            (size, available) => MapEntry(size, available as bool),
          ),
      ratingBreakdown: parseList(json['ratingBreakdown'], RatingShare.fromJson),
      reviews: parseList(json['reviews'], Review.fromJson),
      similarProducts: parseList(json['similarProducts'], Product.fromJson),
      actions: json['actions'] == null
          ? ProductActions.defaults
          : ProductActions.fromJson(json['actions'] as Map<String, dynamic>),
    );
  }

  factory ProductDetails.basic(Product product) {
    return ProductDetails(
      product: product,
      galleryImageUrls: [product.imageUrl],
      rating: 0,
      ratingCount: 0,
      reviewCount: 0,
      description: '',
      descriptionExpanded: false,
      availableColors: const [],
      selectedColorId: null,
      availableSizes: const [],
      selectedSize: null,
      sizeAvailability: const {},
      ratingBreakdown: const [],
      reviews: const [],
      similarProducts: const [],
      actions: ProductActions.defaults,
    );
  }

  final Product product;
  final List<String> galleryImageUrls;
  final double rating;
  final int ratingCount;
  final int reviewCount;
  final String description;
  final bool descriptionExpanded;
  final List<ProductColor> availableColors;
  final String? selectedColorId;
  final List<String> availableSizes;
  final String? selectedSize;
  final Map<String, bool> sizeAvailability;
  final List<RatingShare> ratingBreakdown;
  final List<Review> reviews;
  final List<Product> similarProducts;
  final ProductActions actions;

  bool isSizeAvailable(String size) => sizeAvailability[size] ?? false;
}
