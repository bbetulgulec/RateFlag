import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';

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

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: theme.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white, // Light siyah, Dark beyaz
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.h),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2.h,
            width: isActive ? 24.w : 0,
            color: theme.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ],
      ),
    );
  }
}
