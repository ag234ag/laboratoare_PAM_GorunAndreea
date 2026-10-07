import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 1,
      child: ColoredBox(color: AppColors.divider),
    );
  }
}
