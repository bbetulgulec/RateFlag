import 'package:flutter/material.dart';

class ProfileGestureDetector extends StatelessWidget {
  final VoidCallback? onTap; // Burayı onTap yap
  final IconData icon;
  final int tabIndex;
  final int index; // hangi tab ile karşılaştırılacak

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
        color: tabIndex == index ? Colors.black : Colors.grey,
        size: 28,
      ),
    );
  }
}
