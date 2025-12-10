import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_auth_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_firestore_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/create_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/login_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/update_info_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/view/onboarding_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
        //2.Register Cubit
        BlocProvider<RegisterCubit>(
          create: (context) {
            final authRepository = FirebaseAuthImpl();
            final fireStore = FirebaseFirestoreImpl();

            return RegisterCubit(CreateUserUsecase(fireStore, authRepository));
          },
        ),
        //3.Login Cubit
        BlocProvider<LoginCubit>(
          create: (context) {
            final authRepository = FirebaseAuthImpl();
            return LoginCubit(LoginUserUsecase(authRepository));
          },
        ),
        //4.AccountInfo Cubit
        BlocProvider<AccountInfoCubit>(
          create: (context) {
            final firestoreRepository = FirebaseFirestoreImpl();
            return AccountInfoCubit(UpdateInfoUserUsecase(firestoreRepository));
          },
        ),

        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
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
