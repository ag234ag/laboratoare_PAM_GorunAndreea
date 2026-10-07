import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_network_image.dart';

class RecommendedProductCard extends StatelessWidget {
  const RecommendedProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSpacing.radiusSm);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 213,
        height: 66,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: radius,
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              offset: Offset(0, 6),
              blurRadius: 14,
              spreadRadius: -12,
            ),
          ],
        ),
        child: Row(
          children: [
            AppNetworkImage(
              url: product.imageUrl,
              width: 66,
              height: 66,
              borderRadius: radius,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.productTitle,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.formattedPrice,
                    style: AppTextStyles.productPrice,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
