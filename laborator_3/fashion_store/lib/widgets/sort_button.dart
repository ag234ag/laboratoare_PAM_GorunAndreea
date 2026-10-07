import 'package:flutter/material.dart';

import '../cubits/catalog/catalog_query.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key, required this.value, required this.onSelected});

  final CatalogSort value;
  final ValueChanged<CatalogSort> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CatalogSort>(
      tooltip: 'Sort products',
      initialValue: value,
      onSelected: onSelected,
      itemBuilder: (_) => [
        for (final sort in CatalogSort.values)
          CheckedPopupMenuItem(
            value: sort,
            checked: sort == value,
            child: Text(sort.label, style: AppTextStyles.searchInput),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_vert, size: 18, color: AppColors.textPrimary),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                value.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.chipLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
