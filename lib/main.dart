import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_auth_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_firestore_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_storage_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/create_post_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/create_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/delete_account_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_all_post_user_usercase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/login_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/rate_the_image_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/sign_out_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/update_info_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/upload_image_storage_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/view/onboarding_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/cubit/splash_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/splash/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = FirebaseAuthImpl();
    final fireStore = FirebaseFirestoreImpl();
    final storageRepository = FirebaseStorageImpl();
    return MultiBlocProvider(
      providers: [
        // 1. Onboarding Cubit
        BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(totalPageCount: 3),
        ),
        //2.Register Cubit
        BlocProvider<RegisterCubit>(
          create: (context) {
            return RegisterCubit(CreateUserUsecase(fireStore, authRepository));
          },
        ),
        //3.Login Cubit
        BlocProvider<LoginCubit>(
          create: (context) {
            return LoginCubit(LoginUserUsecase(authRepository));
          },
        ),
        //4.AccountInfo Cubit
        BlocProvider<AccountInfoCubit>(
          create: (context) {
            return AccountInfoCubit(
              UpdateInfoUserUsecase(fireStore),
              DeleteAccountUserUsecase(fireStore, authRepository),
            );
          },
        ),
        //5. PoST cUBİT
        BlocProvider<PostCubit>(
          create: (context) {
            return PostCubit(
              CreatePostUserUsecase(fireStore),
              UploadImageStorageUserUsecase(storageRepository),
            );
          },
        ),

        //6.Profile Cubit
        BlocProvider<ProfileCubit>(
          create: (context) {
            return ProfileCubit(LoadPostUserUsecase(fireStore));
          },
        ),

        //7. Settings Cubit
        BlocProvider<SettingsCubit>(
          create: (context) {
            return SettingsCubit(SignOutUserUsecase(authRepository));
          },
        ),

        //8. Home Cubit
        BlocProvider<HomeCubit>(
          create: (context) {
            final userId = FirebaseAuth.instance.currentUser!.uid;

            return HomeCubit(
              LoadAllPostsUsecase(fireStore),

              userId,
              RateTheImageUserUsecase(fireStore),
            )..loadAllPosts();
          },
        ),
        // 9. PostInfo Cubit
        BlocProvider<PostInfoCubit>(
          create: (context) => PostInfoCubit(LoadPostUserUsecase(fireStore)),
        ),
        // 9. Splash Cubit
        BlocProvider(create: (_) => SplashCubit()..startSplash()),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
