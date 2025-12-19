import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_elevated_button_text.dart';

class OnboardingElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  const OnboardingElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      child: backgroundColor == colors.primary
          ? CustomElevatedButtonText.primary(text: text)
          : CustomElevatedButtonText.secondary(text: text),
    );
  }
}
