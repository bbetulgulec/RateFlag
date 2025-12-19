import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/theme/app_theme.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/cubit/splash_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => getIt<SplashCubit>()..init()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RateFlag',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),

      builder: (context, child) {
        ResponsiveConfig.init(context);
        return child!;
      },
    );
  }
}
