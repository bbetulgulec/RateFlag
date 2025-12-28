import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/common/utils/functions/toast_message.dart';
import 'package:rate_flag/features/rate_flag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/login/cubit/login_state.dart';
import 'package:rate_flag/features/rate_flag/presentaions/login/widget/login_form.dart';

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
            Routes.clearAndPush(context, Routes.main);

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
                Routes.push(context, Routes.register);
              },
            ),
          );
        },
      ),
    );
  }
}
