import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/onboarding_constants.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_state.dart';
import 'package:rate_flag/app/features/presentations/onboarding/widget/onboarding_page_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (p, c) => p.completed != c.completed,
      listener: (context, state) {
        if (state.completed) {
          Routes.replace(context, Routes.login);
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withAlpha(65),
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            child: PageView.builder(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: OnboardingConstants.pages.length,
              itemBuilder: (context, i) {
                return OnboardingPageItem(
                  model: OnboardingConstants.pages[i],
                  index: i,
                  onSkip: cubit.finish,
                  onBack: () => cubit.pageChanged(i - 1),
                  onNext: cubit.nextPage,
                  onFinish: cubit.finish,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
