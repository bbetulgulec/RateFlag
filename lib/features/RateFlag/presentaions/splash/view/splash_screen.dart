import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/view/onboarding_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/cubit/splash_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 SADECE BİR KEZ ÇALIŞIR
    context.read<SplashCubit>().startSplash();

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isFinished) {
          if (state.isAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OnboardingScreen()),
            );
          }
        }
      },
      child: Scaffold(
        body: Center(child: Lottie.asset('assets/lottie/splash.json')),
      ),
    );
  }
}
