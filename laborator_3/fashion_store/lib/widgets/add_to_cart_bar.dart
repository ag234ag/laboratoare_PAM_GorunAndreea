import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AddToCartBar extends StatelessWidget {
  const AddToCartBar({
    super.key,
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? AppColors.bottomBar : AppColors.textMuted,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: InkWell(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        onTap: enabled ? onPressed : null,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_bag,
                  color: AppColors.white,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Text(label, style: AppTextStyles.addToCart),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
