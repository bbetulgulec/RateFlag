import 'package:flutter/material.dart';

class BuildIndicator extends StatelessWidget {
  final int currentIndex;
  final int index;

  const BuildIndicator({
    super.key,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: currentIndex == index ? 20 : 12,
      height: 4,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
