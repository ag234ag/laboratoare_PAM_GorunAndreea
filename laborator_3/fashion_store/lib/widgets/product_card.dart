import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_network_image.dart';
import 'favorite_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.width,
  });

  static const imageAspectRatio = 126 / 172;
  static const textBlockHeight = 56.0;

  final Product product;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: imageAspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    url: product.imageUrl,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FavoriteButton(productId: product.id, size: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.productTitle,
            ),
            const SizedBox(height: 8),
            Text(product.formattedPrice, style: AppTextStyles.productPrice),
          ],
        ),
      ),
    );
  }
}
