import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/features/presentations/follow_list/view/follow_list_screen.dart';
import 'package:rate_flag/app/features/presentations/notificaiton/cubit/notification_cubit.dart';
import 'package:rate_flag/app/features/presentations/notificaiton/view/notification_screen.dart';
import 'package:rate_flag/app/features/presentations/post/cubit/post_cubit.dart';
import 'package:rate_flag/app/features/presentations/post/view/post_screen.dart';
import 'package:rate_flag/core/get_it/service_locator.dart';
import 'package:rate_flag/app/features/data/model/post.dart';
import 'package:rate_flag/app/features/presentations/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/app/features/presentations/account_info/view/account_info_screen.dart';
import 'package:rate_flag/app/features/presentations/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/app/features/presentations/filter_page/view/filter_page_screen.dart';
import 'package:rate_flag/app/features/presentations/home/cubit/home_cubit.dart';
import 'package:rate_flag/app/features/presentations/login/cubit/login_cubit.dart';
import 'package:rate_flag/app/features/presentations/login/view/login_screen.dart';
import 'package:rate_flag/app/features/presentations/main/cubit/main_cubit.dart';
import 'package:rate_flag/app/features/presentations/main/view/main_screen.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/app/features/presentations/onboarding/view/onboarding_screen.dart';
import 'package:rate_flag/app/features/presentations/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/app/features/presentations/post_info/view/post_info_screen.dart';
import 'package:rate_flag/app/features/presentations/register/cubit/register_cubit.dart';
import 'package:rate_flag/app/features/presentations/register/view/register_screen.dart';
import 'package:rate_flag/app/features/presentations/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/app/features/presentations/settings/view/settings_screen.dart';
import 'package:rate_flag/app/features/presentations/splash/view/splash_screen.dart';

class Routes {
  static const String splash = "/splash";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String accountInfo = "/accountInfo";
  static const String filterPage = "/filterPage";
  static const String followList = "/followList";
  static const String home = "/home";
  static const String main = "/main";
  static const String notification = "/notification";
  static const String post = "/post";
  static const String map = "/map";

  static const String postInfo = "/postInfo";
  static const String profile = "/profile";
  static const String setting = "/settings";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<MainCubit>()),
              BlocProvider(create: (_) => getIt<HomeCubit>()),
            ],
            child: const MainScreen(),
          ),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: RegisterScreen(),
          ),
        );

      case accountInfo:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<AccountInfoCubit>(),
            child: AccountInfoScreen(),
          ),
        );

      case postInfo:
        final post = settings.arguments as Post;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PostInfoCubit>()
              ..loadPostInfo(postId: post.postId)
              ..loadFollowStatus(post.userId),
            child: PostInfoScreen(postId: post.postId),
          ),
        );

      case filterPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<FilterPageCubit>()
              ..loadAllUsers()
              ..loadPosts(),
            child: const FilterPageScreen(),
          ),
        );

      case setting:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<SettingsCubit>(),
            child: SettingsScreen(),
          ),
        );
      case followList:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) =>
              FollowListScreen(title: args['title'], userIds: args['userIds']),
        );
      case post:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PostCubit>(),
            child: const PostScreen(),
          ),
        );
      case notification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<NotificationCubit>(),
            child: NotificationScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route bulunamadı'))),
        );
    }
  }

  static void push(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void replace(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void popAndPush(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.popAndPushNamed(context, routeName, arguments: arguments);
  }

  static void clearAndPush(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
