import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/store_repository.dart';
import '../error_message.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._repository, this.productId)
    : super(const ProductDetailsLoading());

  final StoreRepository _repository;
  final String productId;

  Future<void> load() async {
    emit(const ProductDetailsLoading());
    try {
      final details = await _repository.fetchProductDetails(productId);
      if (!isClosed) emit(ProductDetailsSuccess.initial(details));
    } catch (error) {
      if (!isClosed) emit(ProductDetailsError(errorMessage(error)));
    }
  }

  void selectColor(String colorId) {
    final current = state;
    if (current is! ProductDetailsSuccess) return;
    final exists = current.details.availableColors.any((c) => c.id == colorId);
    if (exists) emit(current.copyWith(selectedColorId: colorId));
  }

  void selectSize(String size) {
    final current = state;
    if (current is! ProductDetailsSuccess) return;
    if (current.details.isSizeAvailable(size)) {
      emit(current.copyWith(selectedSize: size));
    }
  }

  void toggleDescription() {
    final current = state;
    if (current is ProductDetailsSuccess) {
      emit(current.copyWith(descriptionExpanded: !current.descriptionExpanded));
    }
  }
}
