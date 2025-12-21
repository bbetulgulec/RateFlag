import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_elevated_button_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;
  final bool isPrimary;

  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.isPrimary = true,
  });

  factory CustomElevatedButton.primary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomElevatedButton(
      text: text,
      onPressed: onPressed,
      isPrimary: true,
    );
  }

  factory CustomElevatedButton.secondary({
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomElevatedButton(
      text: text,
      onPressed: onPressed,
      isPrimary: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor =
        backgroundColor ??
        (isPrimary ? theme.colorScheme.primary : theme.colorScheme.secondary);

    final textColor = isPrimary ? Colors.white : Colors.white;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
