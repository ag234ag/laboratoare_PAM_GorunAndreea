import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: AppTextStyles.family,
    scaffoldBackgroundColor: AppColors.white,
  );
}
