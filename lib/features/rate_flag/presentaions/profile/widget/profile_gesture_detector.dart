import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';

class ProfileGestureDetector extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final int tabIndex;
  final int index;

  const ProfileGestureDetector({
    super.key,
    this.onTap,
    required this.icon,
    required this.tabIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: tabIndex == index
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onSurfaceVariant,
        size: 28.sp,
      ),
    );
  }
}
