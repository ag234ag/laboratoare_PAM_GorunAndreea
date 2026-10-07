import '../../models/home_data.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  const HomeSuccess({required this.data, required this.selectedCategoryId});

  final HomeData data;
  final String? selectedCategoryId;

  HomeSuccess copyWith({String? selectedCategoryId}) {
    return HomeSuccess(
      data: data,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}

final class HomeEmpty extends HomeState {
  const HomeEmpty();
}

final class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;
}
