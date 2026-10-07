import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
    required this.isAvailable,
    required this.selected,
    required this.onSelected,
  });

  final List<String> sizes;
  final bool Function(String size) isAvailable;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final size in sizes)
          _SizeOption(
            size: size,
            available: isAvailable(size),
            selected: size == selected,
            onTap: () => onSelected(size),
          ),
      ],
    );
  }
}

class _SizeOption extends StatelessWidget {
  const _SizeOption({
    required this.size,
    required this.available,
    required this.selected,
    required this.onTap,
  });

  final String size;
  final bool available;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final background = selected ? AppColors.bottomBar : AppColors.placeholder;
    final foreground = selected
        ? AppColors.white
        : available
        ? AppColors.textPrimary
        : AppColors.sizeUnavailable;

    return Semantics(
      label: 'Size $size${available ? '' : ', unavailable'}',
      selected: selected,
      enabled: available,
      button: true,
      child: GestureDetector(
        onTap: available ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle, color: background),
          child: Text(
            size,
            style: AppTextStyles.sizeLabel.copyWith(color: foreground),
          ),
        ),
      ),
    );
  }
}
