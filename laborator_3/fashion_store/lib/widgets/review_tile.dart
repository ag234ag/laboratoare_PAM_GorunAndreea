import 'package:flutter/material.dart';

import '../models/review.dart';
import '../theme/app_text_styles.dart';
import 'app_network_image.dart';
import 'rating_stars.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              url: review.avatarUrl,
              width: 36,
              height: 36,
              borderRadius: BorderRadius.circular(18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.reviewAuthor,
                  ),
                  const SizedBox(height: 4),
                  RatingStars(rating: review.rating, size: 12, spacing: 1),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(review.createdAtLabel, style: AppTextStyles.reviewTime),
          ],
        ),
        const SizedBox(height: 10),
        Text(review.text, style: AppTextStyles.reviewText),
      ],
    );
  }
}
