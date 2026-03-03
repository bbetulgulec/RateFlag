import 'package:flutter/material.dart';
import 'package:rate_flag/app/features/presentations/onboarding/widget/onboarding_button.dart';

class OnboardingBottomControls extends StatelessWidget {
  final int index;
  final bool isLastPage;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const OnboardingBottomControls({
    super.key,
    required this.index,
    required this.isLastPage,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (index > 0)
          OnboardingButton(
            icon: Icons.arrow_back,
            color: colors.primary,
            iconColor: colors.onPrimary,
            onPressed: onBack,
          ),

        if (index == 0) const Spacer(),

        if (!isLastPage)
          OnboardingButton(
            icon: Icons.arrow_forward,
            color: colors.primary,
            iconColor: colors.onPrimary,
            onPressed: onNext,
          ),
      ],
    );
  }
}
