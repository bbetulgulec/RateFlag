import 'package:flutter/material.dart';

class ProfileIconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;

  const ProfileIconWidget({
    super.key,
    required this.icon,
    this.onPressed,
    required this.size,
  });

  factory ProfileIconWidget.small({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return ProfileIconWidget(icon: icon, onPressed: onPressed, size: 24);
  }

  factory ProfileIconWidget.big({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return ProfileIconWidget(icon: icon, onPressed: onPressed, size: 90);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(icon), iconSize: size);
  }
}
