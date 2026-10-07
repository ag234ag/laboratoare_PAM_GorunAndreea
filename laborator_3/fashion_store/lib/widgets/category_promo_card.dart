import 'package:flutter/material.dart';

import '../models/promo.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_network_image.dart';

class CategoryPromoCard extends StatelessWidget {
  const CategoryPromoCard({super.key, required this.promo, this.height = 194});

  final CategoryPromo promo;
  final double height;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSpacing.radiusMd);

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppNetworkImage(url: promo.imageUrl, borderRadius: radius),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00FFFFFF), Color(0xE6FFFFFF)],
                stops: [0.35, 1],
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.category,
                  style: AppTextStyles.bannerEyebrow.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  promo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bannerHeadline.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
