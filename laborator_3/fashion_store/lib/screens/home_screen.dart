import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/catalog/catalog_query.dart';
import '../cubits/favorites/favorites_cubit.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
import '../data/store_repository.dart';
import '../models/catalog_product.dart';
import '../models/home_data.dart';
import '../models/product.dart';
import '../theme/app_spacing.dart';
import '../widgets/category_menu.dart';
import '../widgets/category_promo_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/promo_banner.dart';
import '../widgets/recommended_product_card.dart';
import '../widgets/search_field.dart';
import '../widgets/section_header.dart';
import '../widgets/state_views.dart';
import 'catalog_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<StoreRepository>())..load(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  void _retry(BuildContext context) {
    context.read<FavoritesCubit>().load();
    context.read<HomeCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => switch (state) {
            HomeLoading() => const LoadingView(),
            HomeError(:final message) => ErrorView(
              message: message,
              onRetry: () => _retry(context),
            ),
            HomeEmpty() => MessageView(
              icon: Icons.inventory_2_outlined,
              title: 'No products yet',
              message: 'The store has no products to show right now.',
              actionLabel: 'Reload',
              onAction: () => _retry(context),
            ),
            HomeSuccess(:final data, :final selectedCategoryId) => _HomeContent(
              data: data,
              selectedCategoryId: selectedCategoryId,
            ),
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.data, required this.selectedCategoryId});

  static const _gutter = EdgeInsets.symmetric(
    horizontal: AppSpacing.contentLeft,
  );

  final HomeData data;
  final String? selectedCategoryId;

  void _openDetails(BuildContext context, Product product) {
    Navigator.of(context).push(ProductDetailsScreen.route(product.id));
  }

  void _openCatalog(
    BuildContext context, {
    ProductCollection? collection,
    bool focusSearch = false,
  }) {
    Navigator.of(context).push(
      CatalogScreen.route(
        initialQuery: CatalogQuery(collection: collection),
        focusSearch: focusSearch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 32),
      children: [
        Padding(
          padding: _gutter,
          child: HomeAppBar(
            title: data.storeName,
            onMenu: () => _openCatalog(context),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: _gutter,
          child: SearchField(
            readOnly: true,
            onTap: () => _openCatalog(context, focusSearch: true),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: _gutter,
          child: CategoryMenu(
            categories: data.categories,
            selectedId: selectedCategoryId,
            onSelected: context.read<HomeCubit>().selectCategory,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: _gutter,
          child: HeroBanner(
            banner: data.heroBanner,
            onTap: () => _openCatalog(context),
          ),
        ),
        if (data.featureProducts.isNotEmpty) ...[
          const SizedBox(height: 34),
          Padding(
            padding: _gutter,
            child: SectionHeader(
              title: 'Feature Products',
              onAction: () =>
                  _openCatalog(context, collection: ProductCollection.featured),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height:
                126 / ProductCard.imageAspectRatio +
                ProductCard.textBlockHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: _gutter,
              itemCount: data.featureProducts.length,
              separatorBuilder: (_, _) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final product = data.featureProducts[index];
                return ProductCard(
                  product: product,
                  width: 126,
                  onTap: () => _openDetails(context, product),
                );
              },
            ),
          ),
        ],
        const SizedBox(height: 32),
        PromoBanner(
          promo: data.newCollection,
          height: 168,
          padding: const EdgeInsets.only(left: 48, right: 16),
        ),
        if (data.recommended.isNotEmpty) ...[
          const SizedBox(height: 32),
          Padding(
            padding: _gutter,
            child: SectionHeader(
              title: 'Recommended',
              onAction: () => _openCatalog(
                context,
                collection: ProductCollection.recommended,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 82,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: _gutter.copyWith(bottom: 16),
              itemCount: data.recommended.length,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final product = data.recommended[index];
                return RecommendedProductCard(
                  product: product,
                  onTap: () => _openDetails(context, product),
                );
              },
            ),
          ),
        ],
        if (data.topCollections.isNotEmpty) ...[
          const SizedBox(height: 24),
          Padding(
            padding: _gutter,
            child: const SectionHeader(title: 'Top Collection'),
          ),
          for (var i = 0; i < data.topCollections.length; i++) ...[
            const SizedBox(height: 16),
            Padding(
              padding: _gutter,
              child: PromoBanner(
                promo: data.topCollections[i],
                height: i.isEven ? 141 : 229,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ],
        ],
        if (data.categoryPromos.isNotEmpty) ...[
          const SizedBox(height: 16),
          Padding(
            padding: _gutter,
            child: Row(
              children: [
                for (var i = 0; i < data.categoryPromos.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  Expanded(
                    child: CategoryPromoCard(promo: data.categoryPromos[i]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
