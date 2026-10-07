import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/app_assets.dart';
import '../theme/app_text_styles.dart';

class ExpandableTitle extends StatelessWidget {
  const ExpandableTitle({
    super.key,
    required this.title,
    required this.expanded,
    required this.onTap,
  });

  final String title;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      expanded: expanded,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.blockTitle)),
              AnimatedRotation(
                turns: expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  AppIcons.expandDown,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableSection extends StatefulWidget {
  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = true,
  });

  final String title;
  final Widget child;
  final bool initiallyExpanded;

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExpandableTitle(
          title: widget.title,
          expanded: _expanded,
          onTap: () => setState(() => _expanded = !_expanded),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: _expanded
              ? widget.child
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
