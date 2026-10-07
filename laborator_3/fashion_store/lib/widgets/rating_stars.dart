import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.size = 16,
    this.spacing = 2,
    this.maxStars = 5,
  });

  final double rating;
  final double size;
  final double spacing;
  final int maxStars;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= maxStars; i++) ...[
          if (i > 1) SizedBox(width: spacing),
          Icon(_iconFor(i), size: size, color: AppColors.star),
        ],
      ],
    );
  }

  IconData _iconFor(int position) {
    if (rating >= position) return Icons.star_rounded;
    if (rating >= position - 0.5) return Icons.star_half_rounded;
    return Icons.star_outline_rounded;
  }
}
