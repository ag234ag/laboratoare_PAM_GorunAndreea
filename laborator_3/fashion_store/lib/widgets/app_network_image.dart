import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  final String url;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : _placeholder(),
        errorBuilder: (_, _, _) =>
            _placeholder(icon: Icons.image_not_supported_outlined),
      ),
    );
  }

  Widget _placeholder({IconData? icon}) {
    return SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: AppColors.placeholder,
        child: icon == null
            ? null
            : Center(child: Icon(icon, color: AppColors.iconMuted)),
      ),
    );
  }
}
