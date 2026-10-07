import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class BannerEyebrow extends StatelessWidget {
  const BannerEyebrow({
    super.key,
    required this.label,
    this.style = AppTextStyles.bannerEyebrow,
    this.color = AppColors.textMuted,
  });

  final String label;
  final TextStyle style;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 0.8, height: 12, color: color),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
