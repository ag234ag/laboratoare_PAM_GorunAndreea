import '../../models/product_details.dart';

sealed class ProductDetailsState {
  const ProductDetailsState();
}

final class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

final class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError(this.message);

  final String message;
}

final class ProductDetailsSuccess extends ProductDetailsState {
  const ProductDetailsSuccess({
    required this.details,
    required this.selectedColorId,
    required this.selectedSize,
    required this.descriptionExpanded,
  });

  factory ProductDetailsSuccess.initial(ProductDetails details) {
    return ProductDetailsSuccess(
      details: details,
      selectedColorId: details.selectedColorId,
      selectedSize: details.selectedSize,
      descriptionExpanded: details.descriptionExpanded,
    );
  }

  final ProductDetails details;
  final String? selectedColorId;
  final String? selectedSize;
  final bool descriptionExpanded;

  ProductDetailsSuccess copyWith({
    String? selectedColorId,
    String? selectedSize,
    bool? descriptionExpanded,
  }) {
    return ProductDetailsSuccess(
      details: details,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      selectedSize: selectedSize ?? this.selectedSize,
      descriptionExpanded: descriptionExpanded ?? this.descriptionExpanded,
    );
  }
}
