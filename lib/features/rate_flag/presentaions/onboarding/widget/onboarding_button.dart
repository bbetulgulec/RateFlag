import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';

class OnboardingButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final VoidCallback onPressed;
  const OnboardingButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,

      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
