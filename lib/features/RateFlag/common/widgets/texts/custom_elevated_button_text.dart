import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';

class CustomElevatedButtonText extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const CustomElevatedButtonText({
    super.key,
    required this.text,
    this.isPrimary = true,
  });

  /// Primary button
  factory CustomElevatedButtonText.primary({required String text}) {
    return CustomElevatedButtonText(text: text, isPrimary: true);
  }

  /// Secondary button
  factory CustomElevatedButtonText.secondary({required String text}) {
    return CustomElevatedButtonText(text: text, isPrimary: false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isPrimary
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.primary;

    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
