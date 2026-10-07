import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.count,
    this.activeIndex = 0,
    this.color = AppColors.white,
  });

  final int count;
  final int activeIndex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 14),
          i == activeIndex ? _ActiveDot(color: color) : _Dot(color: color),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ActiveDot extends StatelessWidget {
  const _ActiveDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Container(
        width: 5.5,
        height: 5.5,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
