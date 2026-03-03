import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class Tabitem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const Tabitem({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.h),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2.h,
            width: isActive ? 24.w : 0,
            decoration: BoxDecoration(
              color: colors.onSurface,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
