import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/onboarding_constants.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/widget/onboarding_page_item.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController controller;

  const OnboardingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) =>
          prev.currentPageIndex != curr.currentPageIndex,
      listener: (context, state) {
        controller.animateToPage(
          state.currentPageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: PageView.builder(
        controller: controller,
        itemCount: OnboardingConstants.pages.length,
        onPageChanged: (i) {
          context.read<OnboardingCubit>().pageChanged(i);
        },
        itemBuilder: (context, i) {
          return OnboardingPageItem(
            model: OnboardingConstants.pages[i],
            index: i,
          );
        },
      ),
    );
  }
}
