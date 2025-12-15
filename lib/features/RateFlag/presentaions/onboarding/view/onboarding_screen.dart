import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/widget/onboardingPageView.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.isLastPage) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFB8A3EC), Color.fromARGB(255, 255, 255, 255)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 25.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: state.showSkipButton
                          ? RateFlagText.fadedItalic(text: "Skip")
                          : const SizedBox(),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                Expanded(
                  child: OnboardingPageView(
                    controller: controller,
                    onPageChanged: (i) {
                      context.read<OnboardingCubit>().pageChanged(i);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
