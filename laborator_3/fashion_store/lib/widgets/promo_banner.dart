import 'package:flutter/material.dart';

import '../models/promo.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_network_image.dart';
import 'banner_eyebrow.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.promo,
    required this.height,
    this.borderRadius = BorderRadius.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.titleStyle = AppTextStyles.bannerHeadline,
  });

  final Promo promo;
  final double height;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        child: ColoredBox(
          color: AppColors.promoBackground,
          child: Row(
            children: [
              Expanded(
                flex: 11,
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BannerEyebrow(label: promo.label),
                      const SizedBox(height: 16),
                      Text(
                        promo.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: AppNetworkImage(url: promo.imageUrl, height: height),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
