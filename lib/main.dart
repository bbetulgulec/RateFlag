import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/features/data/domain/repositories/notification_permission_repository.dart';
import 'package:rate_flag/core/get_it/service_locator.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/features/presentations/internet/cubit/internet_cubit.dart';
import 'package:rate_flag/app/features/presentations/internet/view/internet_gate.dart';
import 'package:rate_flag/core/service/notifications/local_notification_service.dart';
import 'package:rate_flag/app/features/presentations/splash/cubit/splash_cubit.dart';
import 'package:rate_flag/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupGetIt();
  final notificationRepo = getIt<NotificationPermissionRepository>();

  await notificationRepo.init();

  await LocalNotificationService.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => getIt<SplashCubit>()..init()),
        BlocProvider<InternetCubit>(create: (_) => InternetCubit()),
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
      title: 'rate_flag',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.onGenerateRoute,

      builder: (context, child) {
        ResponsiveConfig.init(context);
        return InternetGate(child: child!);
      },
    );
  }
}
