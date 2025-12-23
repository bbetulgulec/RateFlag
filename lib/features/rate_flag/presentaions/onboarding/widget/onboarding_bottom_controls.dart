import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/widget/onboarding_button.dart';

class OnboardingBottomControls extends StatelessWidget {
  final int index;
  final bool isLastPage;

  const OnboardingBottomControls({
    super.key,
    required this.index,
    required this.isLastPage,
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
            onPressed: () {
              context.read<OnboardingCubit>().pageChanged(index - 1);
            },
          ),
        if (index == 0) const Spacer(),
        if (!isLastPage)
          OnboardingButton(
            icon: Icons.arrow_forward,
            color: colors.primary,
            iconColor: colors.onPrimary,
            onPressed: () {
              context.read<OnboardingCubit>().nextPage();
            },
          ),
      ],
    );
  }
}
