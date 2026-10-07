import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/shop_category.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<ShopCategory> categories;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final category in categories)
          _CategoryItem(
            category: category,
            selected: category.id == selectedId,
            onTap: () => onSelected(category.id),
          ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final ShopCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? AppColors.categoryActive
        : AppColors.categoryInactive;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 42,
              height: 42,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColors.categoryActive
                      : Colors.transparent,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? AppColors.categoryActive
                      : AppColors.placeholder,
                ),
                child: Center(
                  child: SvgPicture.network(
                    category.iconUrl,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      selected ? AppColors.white : AppColors.categoryInactive,
                      BlendMode.srcIn,
                    ),
                    placeholderBuilder: (_) =>
                        const SizedBox.square(dimension: 20),
                    errorBuilder: (_, _, _) => Icon(
                      Icons.category_outlined,
                      size: 20,
                      color: selected
                          ? AppColors.white
                          : AppColors.categoryInactive,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.categoryLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
