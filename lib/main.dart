import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/view/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 1. Onboarding Cubit
        BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(totalPageCount: 3),
        ),

        // 2. Diğer Cubit'leri buraya ekleyebilirsiniz
        // BlocProvider<AuthCubit>(
        //   create: (context) => AuthCubit(),
        // ),
        // BlocProvider<UserCubit>(
        //   create: (context) => UserCubit(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
