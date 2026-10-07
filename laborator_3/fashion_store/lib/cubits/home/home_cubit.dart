import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/store_repository.dart';
import '../error_message.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeLoading());

  final StoreRepository _repository;

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      final data = await _repository.fetchHome();
      if (isClosed) return;
      emit(
        data.hasProducts
            ? HomeSuccess(
                data: data,
                selectedCategoryId: data.initialCategoryId,
              )
            : const HomeEmpty(),
      );
    } catch (error) {
      if (!isClosed) emit(HomeError(errorMessage(error)));
    }
  }

  void selectCategory(String categoryId) {
    final current = state;
    if (current is HomeSuccess) {
      emit(current.copyWith(selectedCategoryId: categoryId));
    }
  }
}
