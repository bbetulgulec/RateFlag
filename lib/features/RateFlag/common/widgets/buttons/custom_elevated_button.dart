import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_elevated_button_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.backgroundColor,
  });

  factory CustomElevatedButton.primary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomElevatedButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: Colors.deepPurple,
    );
  }

  factory CustomElevatedButton.secondary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomElevatedButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: Color(0xFFDDCDFD),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: backgroundColor == Colors.deepPurple
          ? CustomElevatedButtonText.primary(text: text)
          : CustomElevatedButtonText.secondary(text: text),
    );
  }
}
