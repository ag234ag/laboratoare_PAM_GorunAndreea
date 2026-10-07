import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const family = 'ProductSans';

  static const sectionTitle = TextStyle(
    fontFamily: family,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1,
    color: AppColors.black,
  );

  static const showAll = TextStyle(
    fontFamily: family,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 20 / 13,
    letterSpacing: -0.13,
    color: AppColors.textShowAll,
  );

  static const categoryLabel = TextStyle(
    fontFamily: family,
    fontSize: 10,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 0.06,
  );

  static const heroBannerTitle = TextStyle(
    fontFamily: family,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.41,
    color: AppColors.white,
  );

  static const bannerEyebrow = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 16 / 12,
    color: AppColors.textMuted,
  );

  static const bannerHeadline = TextStyle(
    fontFamily: family,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1,
    color: AppColors.bannerHeadline,
  );

  static const productTitle = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: -0.12,
    color: AppColors.textPrimary,
  );

  static const productPrice = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 19 / 16,
    color: AppColors.textPrimary,
  );

  static const detailsTitle = TextStyle(
    fontFamily: family,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1,
    color: AppColors.textPrimary,
  );

  static const detailsPrice = TextStyle(
    fontFamily: family,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.41,
    color: AppColors.black,
  );

  static const ratingCount = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.textPrimary,
  );

  static const optionLabel = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textMuted,
  );

  static const blockTitle = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.41,
    color: AppColors.textHeading,
  );

  static const body = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 20 / 12,
    color: AppColors.textPrimary,
  );

  static const link = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 20 / 12,
    color: AppColors.link,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.link,
  );

  static const ratingValue = TextStyle(
    fontFamily: family,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 45 / 40,
    letterSpacing: 0.48,
    color: AppColors.ratingValue,
  );

  static const ratingScale = TextStyle(
    fontFamily: family,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 13 / 11,
    letterSpacing: 0.07,
    color: AppColors.textSubtle,
  );

  static const ratingsTotal = TextStyle(
    fontFamily: family,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 12 / 10,
    letterSpacing: 0.06,
    color: AppColors.textSubtle,
  );

  static const reviewMeta = TextStyle(
    fontFamily: family,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 17 / 11,
    letterSpacing: -0.055,
    color: AppColors.textSubtle,
  );

  static const reviewAuthor = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textHeading,
  );

  static const reviewTime = TextStyle(
    fontFamily: family,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 17 / 11,
    color: AppColors.timestamp,
  );

  static const reviewText = TextStyle(
    fontFamily: family,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 17 / 11,
    letterSpacing: -0.055,
    color: AppColors.black,
  );

  static const searchInput = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  static const chipLabel = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: AppColors.textPrimary,
  );

  static const sizeLabel = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1,
    color: AppColors.textPrimary,
  );

  static const stateTitle = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.41,
    color: AppColors.textHeading,
  );

  static const stateMessage = TextStyle(
    fontFamily: family,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 20 / 13,
    color: AppColors.textMuted,
  );

  static const addToCart = TextStyle(
    fontFamily: family,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.41,
    color: AppColors.white,
  );
}
