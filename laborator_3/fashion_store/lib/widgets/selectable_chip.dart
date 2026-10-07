import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? AppColors.white : AppColors.textPrimary;
    final chipIcon = icon;

    return Semantics(
      selected: selected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? AppColors.chipSelected : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.chipSelected : AppColors.divider,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (chipIcon != null) ...[
                Icon(
                  chipIcon,
                  size: 14,
                  color: selected ? AppColors.white : AppColors.favorite,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: AppTextStyles.chipLabel.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
