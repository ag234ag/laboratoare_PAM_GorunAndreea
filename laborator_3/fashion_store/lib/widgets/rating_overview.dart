import 'package:flutter/material.dart';

import '../models/product_details.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'rating_stars.dart';

class RatingOverview extends StatelessWidget {
  const RatingOverview({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.breakdown,
  });

  final double rating;
  final int ratingCount;
  final List<RatingShare> breakdown;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(rating.toStringAsFixed(1), style: AppTextStyles.ratingValue),
            const SizedBox(width: 10),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'OUT OF 5',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.ratingScale,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RatingStars(rating: rating, size: 18),
                const SizedBox(height: 6),
                Text('$ratingCount ratings', style: AppTextStyles.ratingsTotal),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final share in breakdown) _ShareBar(share: share),
      ],
    );
  }
}

class _ShareBar extends StatelessWidget {
  const _ShareBar({required this.share});

  final RatingShare share;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            child: Text('${share.stars}', style: AppTextStyles.ratingsTotal),
          ),
          const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (share.percentage / 100).clamp(0, 1),
                minHeight: 6,
                color: AppColors.star,
                backgroundColor: AppColors.placeholder,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 34,
            child: Text(
              '${share.percentage.round()}%',
              textAlign: TextAlign.right,
              style: AppTextStyles.ratingsTotal,
            ),
          ),
        ],
      ),
    );
  }
}
