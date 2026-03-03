import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomAppBar(
      height: 60.h,
      color: colors.primary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.article_outlined, color: Colors.white),
            onPressed: () => onTap(0),
          ),

          SizedBox(width: 20.w),

          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () => onTap(1),
          ),
        ],
      ),
    );
  }
}
