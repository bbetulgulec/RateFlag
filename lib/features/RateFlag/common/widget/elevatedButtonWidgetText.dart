import 'package:flutter/material.dart';

class ElevatedbuttonWidgetText extends StatelessWidget {
  final String text;
  final Color color;
  const ElevatedbuttonWidgetText({
    super.key,
    required this.text,
    required this.color,
  });

  factory ElevatedbuttonWidgetText.primary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return ElevatedbuttonWidgetText(text: text, color: Colors.white);
  }

  factory ElevatedbuttonWidgetText.secondary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return ElevatedbuttonWidgetText(text: text, color: Colors.deepPurple);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}
