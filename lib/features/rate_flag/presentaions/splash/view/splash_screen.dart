import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_flag/features/rate_flag/common/constants/assets_path.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/presentaions/splash/cubit/splash_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/splash/cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (!state.isFinished) return;

        if (state.isAuthenticated) {
          Routes.replace(context, Routes.main);
        } else {
          Routes.replace(context, Routes.onboarding);
        }
      },
      child: Scaffold(body: Center(child: Lottie.asset(AssetsPath.splash))),
    );
  }
}
