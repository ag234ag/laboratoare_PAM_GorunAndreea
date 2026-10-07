import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/favorites/favorites_cubit.dart';
import '../theme/app_colors.dart';
import 'circle_icon_button.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.productId, this.size = 32});

  final String productId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavoritesCubit, bool>(
      (cubit) => cubit.state.contains(productId),
    );

    return CircleIconButton(
      icon: isFavorite ? Icons.favorite : Icons.favorite_border,
      iconColor: isFavorite ? AppColors.favorite : AppColors.textMuted,
      size: size,
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      onPressed: () => context.read<FavoritesCubit>().toggle(productId),
    );
  }
}
