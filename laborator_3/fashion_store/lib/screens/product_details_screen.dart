import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/details/product_details_cubit.dart';
import '../cubits/details/product_details_state.dart';
import '../data/store_repository.dart';
import '../models/product_details.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/add_to_cart_bar.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/color_selector.dart';
import '../widgets/divider_line.dart';
import '../widgets/expandable_title.dart';
import '../widgets/favorite_button.dart';
import '../widgets/product_card.dart';
import '../widgets/product_gallery.dart';
import '../widgets/rating_overview.dart';
import '../widgets/rating_stars.dart';
import '../widgets/review_tile.dart';
import '../widgets/size_selector.dart';
import '../widgets/state_views.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static Route<void> route(String productId) {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailsScreen(productId: productId),
    );
  }

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit(context.read<StoreRepository>(), productId)
            ..load(),
      child: const _DetailsView(),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.bottomBar,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) => switch (state) {
          ProductDetailsLoading() => const _StatusScaffold(
            child: LoadingView(),
          ),
          ProductDetailsError(:final message) => _StatusScaffold(
            child: ErrorView(
              message: message,
              onRetry: context.read<ProductDetailsCubit>().load,
            ),
          ),
          ProductDetailsSuccess() => _DetailsContent(state: state),
        },
      ),
    );
  }
}

class _StatusScaffold extends StatelessWidget {
  const _StatusScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.detailsBackground,
      appBar: AppBar(
        backgroundColor: AppColors.detailsBackground,
        surfaceTintColor: AppColors.detailsBackground,
        foregroundColor: AppColors.textPrimary,
      ),
      body: child,
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.state});

  static const _galleryHeight = 430.0;
  static const _sheetOverlap = 24.0;

  final ProductDetailsSuccess state;

  void _addToCart(BuildContext context) {
    final details = state.details;
    final options = [
      details.availableColors
          .where((c) => c.id == state.selectedColorId)
          .map((c) => c.name)
          .firstOrNull,
      state.selectedSize,
    ].whereType<String>().join(', ');

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            '${details.product.name}${options.isEmpty ? '' : ' ($options)'} added to cart',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final details = state.details;
    final top = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.detailsBackground,
      bottomNavigationBar: AddToCartBar(
        label: details.actions.addToCartLabel,
        enabled: details.actions.canAddToCart,
        onPressed: () => _addToCart(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductGallery(
              imageUrls: details.galleryImageUrls,
              height: _galleryHeight,
              overlay: [
                Positioned(
                  left: 24,
                  top: top + 16,
                  child: CircleIconButton(
                    icon: Icons.arrow_back_ios_new,
                    size: 36,
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
                Positioned(
                  right: 24,
                  top: top + 18,
                  child: FavoriteButton(productId: details.product.id),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -_sheetOverlap),
              child: _Sheet(state: state),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({required this.state});

  final ProductDetailsSuccess state;

  @override
  Widget build(BuildContext context) {
    final details = state.details;
    final cubit = context.read<ProductDetailsCubit>();
    final hasOptions =
        details.availableColors.isNotEmpty || details.availableSizes.isNotEmpty;

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusSheet),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sheetShadow,
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.contentLeft,
          40,
          AppSpacing.contentLeft,
          32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Summary(details: details),
            const SizedBox(height: 18),
            const DividerLine(),
            if (hasOptions) ...[
              const SizedBox(height: 18),
              _Options(state: state),
              const SizedBox(height: 22),
              const DividerLine(),
            ],
            if (details.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              ExpandableTitle(
                title: 'Description',
                expanded: state.descriptionExpanded,
                onTap: cubit.toggleDescription,
              ),
              const DividerLine(),
              const SizedBox(height: 20),
              _Description(
                text: details.description,
                expanded: state.descriptionExpanded,
                onToggle: cubit.toggleDescription,
              ),
            ],
            const SizedBox(height: 24),
            ExpandableSection(
              title: 'Reviews',
              child: _Reviews(details: details),
            ),
            if (details.similarProducts.isNotEmpty) ...[
              const SizedBox(height: 16),
              ExpandableSection(
                title: 'Similar Product',
                child: _SimilarProducts(details: details),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  details.product.name,
                  style: AppTextStyles.detailsTitle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              details.product.formattedPrice,
              style: AppTextStyles.detailsPrice,
            ),
          ],
        ),
        if (details.ratingCount > 0) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              RatingStars(rating: details.rating, size: 18, spacing: 4),
              const SizedBox(width: 6),
              Text(
                '(${details.ratingCount})',
                style: AppTextStyles.ratingCount,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({required this.state});

  final ProductDetailsSuccess state;

  @override
  Widget build(BuildContext context) {
    final details = state.details;
    final cubit = context.read<ProductDetailsCubit>();

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 16,
      spacing: 24,
      children: [
        if (details.availableColors.isNotEmpty)
          _LabeledOption(
            label: 'Color',
            child: ColorSelector(
              colors: details.availableColors,
              selectedId: state.selectedColorId,
              onSelected: cubit.selectColor,
            ),
          ),
        if (details.availableSizes.isNotEmpty)
          _LabeledOption(
            label: 'Size',
            child: SizeSelector(
              sizes: details.availableSizes,
              isAvailable: details.isSizeAvailable,
              selected: state.selectedSize,
              onSelected: cubit.selectSize,
            ),
          ),
      ],
    );
  }
}

class _LabeledOption extends StatelessWidget {
  const _LabeledOption({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.optionLabel),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.text,
    required this.expanded,
    required this.onToggle,
  });

  final String text;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: Text(
            text,
            maxLines: expanded ? null : 3,
            overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: AppTextStyles.body,
          ),
        ),
        TextButton(
          onPressed: onToggle,
          child: Text(
            expanded ? 'Read less' : 'Read more',
            style: AppTextStyles.link,
          ),
        ),
      ],
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({required this.details});

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    if (details.reviews.isEmpty && details.ratingCount == 0) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'No reviews yet. Be the first to review this product.',
          textAlign: TextAlign.center,
          style: AppTextStyles.stateMessage,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DividerLine(),
        const SizedBox(height: 24),
        RatingOverview(
          rating: details.rating,
          ratingCount: details.ratingCount,
          breakdown: details.ratingBreakdown,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                '${details.reviewCount} Reviews',
                style: AppTextStyles.reviewMeta,
              ),
            ),
            const Text('WRITE A REVIEW', style: AppTextStyles.reviewMeta),
            const SizedBox(width: 6),
            const Icon(Icons.edit, size: 16, color: AppColors.iconMuted),
          ],
        ),
        for (final review in details.reviews) ...[
          const SizedBox(height: 24),
          ReviewTile(review: review),
        ],
      ],
    );
  }
}

class _SimilarProducts extends StatelessWidget {
  const _SimilarProducts({required this.details});

  static const _cardWidth = 126.0;

  final ProductDetails details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DividerLine(),
        const SizedBox(height: 24),
        SizedBox(
          height:
              _cardWidth / ProductCard.imageAspectRatio +
              ProductCard.textBlockHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: details.similarProducts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final product = details.similarProducts[index];
              return ProductCard(
                product: product,
                width: _cardWidth,
                onTap: () =>
                    Navigator.of(context)
                        .push(ProductDetailsScreen.route(product.id)),
              );
            },
          ),
        ),
      ],
    );
  }
}
