import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/presentaions/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/account_info/view/account_info_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/filter_page/view/filter_page_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/follow_list/view/follow_list_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/main/cubit/main_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/notificaiton/cubit/notification_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/notificaiton/view/notification_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/onboarding/view/onboarding_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/view/post_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post_info/view/post_info_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/register/cubit/register_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/register/view/register_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/settings/view/settings_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/splash/view/splash_screen.dart';

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
