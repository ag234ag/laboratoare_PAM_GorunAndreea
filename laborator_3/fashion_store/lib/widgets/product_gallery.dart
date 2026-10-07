import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_network_image.dart';
import 'page_indicator.dart';

class ProductGallery extends StatefulWidget {
  const ProductGallery({
    super.key,
    required this.imageUrls,
    required this.height,
    this.overlay = const [],
  });

  final List<String> imageUrls;
  final double height;
  final List<Widget> overlay;

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (_, index) => AppNetworkImage(
              url: widget.imageUrls[index],
              alignment: Alignment.topCenter,
            ),
          ),
          if (widget.imageUrls.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: PageIndicator(
                  count: widget.imageUrls.length,
                  activeIndex: _page,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ...widget.overlay,
        ],
      ),
    );
  }
}
