import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/store_repository.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  FavoritesCubit(this._repository) : super(const <String>{});

  final StoreRepository _repository;

  Future<void> load() async {
    try {
      final ids = await _repository.fetchFavoriteIds();
      if (!isClosed) emit({...ids, ...state});
    } on StoreDataException {
      return;
    }
  }

  bool isFavorite(String productId) => state.contains(productId);

  void toggle(String productId) {
    emit(
      isFavorite(productId)
          ? (Set.of(state)..remove(productId))
          : {...state, productId},
    );
  }
}
