import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidgetText.dart';

class Onboardingelevetedbutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  const Onboardingelevetedbutton({
    super.key,
    this.onPressed,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: backgroundColor == Colors.deepPurple
          ? ElevatedbuttonWidgetText.primary(text: text)
          : ElevatedbuttonWidgetText.secondary(text: text),
    );
  }
}
