import 'package:flutter/material.dart';

import '../models/hero_banner.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_network_image.dart';
import 'page_indicator.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key, required this.banner, this.onTap});

  final HeroBannerData banner;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSpacing.radiusLg);

    return Semantics(
      button: onTap != null,
      label: '${banner.title}. ${banner.action}',
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 312 / 168,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(url: banner.imageUrl, borderRadius: radius),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0x00000000), Color(0x8C000000)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 19, 16, 17),
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  banner.title,
                                  style: AppTextStyles.heroBannerTitle,
                                ),
                                if (banner.action.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    banner.action,
                                    style: AppTextStyles.link.copyWith(
                                      color: AppColors.white,
                                      decorationColor: AppColors.white,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    PageIndicator(
                      count: banner.slides,
                      activeIndex: banner.activeSlide,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
