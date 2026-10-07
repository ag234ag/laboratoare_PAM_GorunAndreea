import 'package:bloc_test/bloc_test.dart';
import 'package:fashion_store/cubits/details/product_details_cubit.dart';
import 'package:fashion_store/cubits/details/product_details_state.dart';
import 'package:fashion_store/cubits/favorites/favorites_cubit.dart';
import 'package:fashion_store/cubits/home/home_cubit.dart';
import 'package:fashion_store/cubits/home/home_state.dart';
import 'package:fashion_store/data/store_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/fake_store_repository.dart';

void main() {
  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'emits Loading then Success with the JSON-selected category',
      build: () => HomeCubit(FakeStoreRepository()),
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeSuccess>().having(
          (s) => s.selectedCategoryId,
          'category',
          'women',
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits Empty when there are no products',
      build: () => HomeCubit(
        FakeStoreRepository(
          home: sampleHome(featured: const [], recommended: const []),
        ),
      ),
      act: (cubit) => cubit.load(),
      expect: () => [isA<HomeLoading>(), isA<HomeEmpty>()],
    );

    blocTest<HomeCubit, HomeState>(
      'emits Error with a generic message for unknown failures',
      build: () => HomeCubit(FakeStoreRepository(error: StateError('boom'))),
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>().having(
          (s) => s.message,
          'message',
          contains('try again'),
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'selectCategory updates the selection',
      build: () => HomeCubit(FakeStoreRepository()),
      act: (cubit) async {
        await cubit.load();
        cubit.selectCategory('men');
      },
      skip: 2,
      expect: () => [
        isA<HomeSuccess>().having(
          (s) => s.selectedCategoryId,
          'category',
          'men',
        ),
      ],
    );
  });

  group('ProductDetailsCubit', () {
    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'starts with the selections from the data',
      build: () => ProductDetailsCubit(FakeStoreRepository(), 'p1'),
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<ProductDetailsLoading>(),
        isA<ProductDetailsSuccess>()
            .having((s) => s.selectedColorId, 'color', 'beige')
            .having((s) => s.selectedSize, 'size', 'L')
            .having((s) => s.descriptionExpanded, 'expanded', false),
      ],
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'ignores unavailable sizes and unknown colors',
      build: () => ProductDetailsCubit(FakeStoreRepository(), 'p1'),
      act: (cubit) async {
        await cubit.load();
        cubit
          ..selectSize('S')
          ..selectColor('purple')
          ..selectSize('M')
          ..selectColor('black')
          ..toggleDescription();
      },
      skip: 2,
      expect: () => [
        isA<ProductDetailsSuccess>().having((s) => s.selectedSize, 'size', 'M'),
        isA<ProductDetailsSuccess>().having(
          (s) => s.selectedColorId,
          'color',
          'black',
        ),
        isA<ProductDetailsSuccess>().having(
          (s) => s.descriptionExpanded,
          'expanded',
          true,
        ),
      ],
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits Error for unknown products',
      build: () => ProductDetailsCubit(FakeStoreRepository(), 'nope'),
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<ProductDetailsLoading>(),
        isA<ProductDetailsError>().having(
          (s) => s.message,
          'message',
          contains('nope'),
        ),
      ],
    );
  });

  group('FavoritesCubit', () {
    blocTest<FavoritesCubit, Set<String>>(
      'loads initial favorites and toggles them',
      build: () => FavoritesCubit(FakeStoreRepository(favoriteIds: {'p1'})),
      act: (cubit) async {
        await cubit.load();
        cubit
          ..toggle('p2')
          ..toggle('p1');
      },
      expect: () => [
        {'p1'},
        {'p1', 'p2'},
        {'p2'},
      ],
    );

    blocTest<FavoritesCubit, Set<String>>(
      'keeps current favorites when loading fails',
      build: () => FavoritesCubit(
        FakeStoreRepository(error: const StoreDataException('broken')),
      ),
      act: (cubit) => cubit.load(),
      expect: () => const <Set<String>>[],
    );
  });
}
