import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/view/onboarding_page_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

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
        child: OnboardingPageView(controller: controller),
      ),
    );
  }
}
