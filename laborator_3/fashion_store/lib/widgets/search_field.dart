import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onClear,
    this.autofocus = false,
    this.readOnly = false,
    this.hint = 'Search products',
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final bool autofocus;
  final bool readOnly;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      borderSide: BorderSide.none,
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      autofocus: autofocus,
      readOnly: readOnly,
      textInputAction: TextInputAction.search,
      style: AppTextStyles.searchInput,
      cursorColor: AppColors.chipSelected,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.placeholder,
        hintText: hint,
        hintStyle: AppTextStyles.searchInput.copyWith(
          color: AppColors.textSubtle,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textSubtle,
          size: 20,
        ),
        suffixIcon: onClear == null
            ? null
            : IconButton(
                tooltip: 'Clear search',
                icon: const Icon(Icons.close, size: 18),
                color: AppColors.textSubtle,
                onPressed: onClear,
              ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
