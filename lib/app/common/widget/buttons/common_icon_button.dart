import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;
  final bool isVisible;

  const CommonIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isVisible = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return SizedBox(width: 55.w);
    }

    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }
}
