import 'package:flutter/material.dart';

import '../models/product_details.dart';
import '../theme/app_colors.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedId,
    required this.onSelected,
  });

  final List<ProductColor> colors;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        for (final color in colors)
          Semantics(
            label: color.name,
            selected: color.id == selectedId,
            button: true,
            child: GestureDetector(
              onTap: () => onSelected(color.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  boxShadow: color.id == selectedId
                      ? const [
                          BoxShadow(
                            color: AppColors.sheetShadow,
                            blurRadius: 6,
                          ),
                        ]
                      : null,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.color,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
