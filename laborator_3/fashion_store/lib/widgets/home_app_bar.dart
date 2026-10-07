import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/app_assets.dart';
import '../theme/app_text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.title, this.onMenu});

  final String title;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        children: [
          GestureDetector(
            onTap: onMenu,
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(AppIcons.menu, width: 20, height: 19),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionTitle,
            ),
          ),
          SvgPicture.asset(AppIcons.notification, width: 25, height: 26),
        ],
      ),
    );
  }
}
