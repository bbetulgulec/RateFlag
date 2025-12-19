import 'package:flutter/material.dart';

class CustomElevatedButtonText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomElevatedButtonText({
    super.key,
    required this.text,
    required this.color,
  });

  factory CustomElevatedButtonText.primary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomElevatedButtonText(text: text, color: Colors.white);
  }

  factory CustomElevatedButtonText.secondary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomElevatedButtonText(text: text, color: Colors.deepPurple);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}
