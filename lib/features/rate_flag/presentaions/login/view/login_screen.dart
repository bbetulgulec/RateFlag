import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/utils/functions/toast_message.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/login_form.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/cubit/main_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/view/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            context.read<LoginCubit>().clearError();
          }

          if (state.loginStatus == LoginStatus.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => getIt<MainCubit>()),
                    BlocProvider(create: (_) => getIt<HomeCubit>()),
                  ],
                  child: MainScreen(),
                ),
              ),
            );
            ToastMessage.show(
              context,
              TextConstants.login,
              icon: Icons.check_circle,
            );
          }

          if (state.passwordResetStatus == LoginStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(TextConstants.sendResetPassword)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: LoginForm(
              isLoading: state.loginStatus == LoginStatus.loading,
              isResetLoading: state.passwordResetStatus == LoginStatus.loading,

              onEmailChanged: cubit.emailChanged,
              onPasswordChanged: cubit.passwordChanged,

              onLoginPressed: cubit.login,
              onForgotPasswordPressed: cubit.forgotPassword,

              onRegisterPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => getIt<RegisterCubit>(),
                      child: RegisterScreen(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
