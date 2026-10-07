import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/catalog/catalog_cubit.dart';
import '../cubits/catalog/catalog_query.dart';
import '../cubits/catalog/catalog_state.dart';
import '../cubits/favorites/favorites_cubit.dart';
import '../data/store_repository.dart';
import '../models/catalog_product.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/product_card.dart';
import '../widgets/search_field.dart';
import '../widgets/selectable_chip.dart';
import '../widgets/sort_button.dart';
import '../widgets/state_views.dart';
import 'product_details_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({
    super.key,
    this.initialQuery = const CatalogQuery(),
    this.focusSearch = false,
  });

  static Route<void> route({
    CatalogQuery initialQuery = const CatalogQuery(),
    bool focusSearch = false,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) =>
          CatalogScreen(initialQuery: initialQuery, focusSearch: focusSearch),
    );
  }

  final CatalogQuery initialQuery;
  final bool focusSearch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogCubit(
        context.read<StoreRepository>(),
        initialQuery: initialQuery,
        favoriteIds: context.read<FavoritesCubit>().state,
      )..load(),
      child: BlocListener<FavoritesCubit, Set<String>>(
        listener: (context, ids) =>
            context.read<CatalogCubit>().updateFavorites(ids),
        child: _CatalogView(focusSearch: focusSearch),
      ),
    );
  }
}

class _CatalogView extends StatefulWidget {
  const _CatalogView({required this.focusSearch});

  final bool focusSearch;

  @override
  State<_CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<_CatalogView> {
  late final TextEditingController _search = TextEditingController(
    text: context.read<CatalogCubit>().query.search,
  );

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _search.clear();
    context.read<CatalogCubit>().search('');
  }

  void _clearAll() {
    _search.clear();
    context.read<CatalogCubit>().clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CatalogCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Shop', style: AppTextStyles.sectionTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.contentLeft,
              8,
              AppSpacing.contentLeft,
              12,
            ),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _search,
              builder: (_, value, _) => SearchField(
                controller: _search,
                autofocus: widget.focusSearch,
                onChanged: cubit.search,
                onClear: value.text.isEmpty ? null : _clearSearch,
              ),
            ),
          ),
          BlocBuilder<CatalogCubit, CatalogState>(
            buildWhen: (previous, current) => current is CatalogReady,
            builder: (context, state) {
              final query = state is CatalogReady ? state.query : cubit.query;
              return _FilterBar(query: query, cubit: cubit);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<CatalogCubit, CatalogState>(
              builder: (context, state) => switch (state) {
                CatalogLoading() => const LoadingView(),
                CatalogError(:final message) => ErrorView(
                  message: message,
                  onRetry: cubit.load,
                ),
                CatalogEmpty(:final query) => MessageView(
                  icon: query.favoritesOnly
                      ? Icons.favorite_border
                      : Icons.search_off,
                  title: query.isFiltered
                      ? 'No matching products'
                      : 'No products available',
                  message: query.isFiltered
                      ? 'Try another search or remove some filters.'
                      : 'The catalog is empty right now.',
                  actionLabel: query.isFiltered ? 'Clear filters' : null,
                  onAction: query.isFiltered ? _clearAll : null,
                ),
                CatalogSuccess(:final products) => _ProductGrid(
                  products: products,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.query, required this.cubit});

  final CatalogQuery query;
  final CatalogCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 34,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.contentLeft,
            ),
            children: [
              SelectableChip(
                label: 'All',
                selected: query.collection == null,
                onTap: () => cubit.filterByCollection(null),
              ),
              for (final collection in ProductCollection.values) ...[
                const SizedBox(width: 8),
                SelectableChip(
                  label: collection.label,
                  selected: query.collection == collection,
                  onTap: () => cubit.filterByCollection(collection),
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.contentLeft,
            8,
            AppSpacing.contentLeft - 4,
            0,
          ),
          child: Row(
            children: [
              SelectableChip(
                label: 'Favorites',
                icon: query.favoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border,
                selected: query.favoritesOnly,
                onTap: cubit.toggleFavoritesOnly,
              ),
              const Spacer(),
              Flexible(
                flex: 3,
                child: SortButton(value: query.sort, onSelected: cubit.sortBy),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        final columns = constraints.maxWidth >= 600 ? 3 : 2;
        final cellWidth =
            (constraints.maxWidth -
                AppSpacing.contentLeft * 2 -
                spacing * (columns - 1)) /
            columns;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.contentLeft,
            8,
            AppSpacing.contentLeft,
            32,
          ),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: 20,
            mainAxisExtent:
                cellWidth / ProductCard.imageAspectRatio +
                ProductCard.textBlockHeight,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onTap: () =>
                  Navigator.of(context)
                      .push(ProductDetailsScreen.route(product.id)),
            );
          },
        );
      },
    );
  }
}
