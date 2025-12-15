import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/toast_message.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/login_form.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/view/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.loginStatus == LoginStatus.success) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
            );

            ToastMessage.show(context, message: "Başarıyla Giriş yapıldı");
          }

          if (state.passwordResetStatus == LoginStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Şifre sıfırlama maili gönderildi")),
            );
          }
        },
        builder: (context, state) {
          return LoginFormWidget(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            isLoading: state.loginStatus == LoginStatus.loading,
            isResetLoading: state.passwordResetStatus == LoginStatus.loading,
            onLoginPressed: () async {
              if (!_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Lütfen tüm alanları doğru doldurun"),
                  ),
                );
                return;
              }

              await cubit.login(
                _emailController.text.trim(),
                _passwordController.text.trim(),
              );
            },
            onForgotPasswordPressed: () {
              final email = _emailController.text.trim();

              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lütfen e-posta giriniz")),
                );
                return;
              }

              cubit.forgotPassword(email);
            },
            onRegisterPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegisterScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
