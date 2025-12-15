import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/loginTextButton.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.isResetLoading,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onRegisterPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool isLoading;
  final bool isResetLoading;

  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RateFlagText.head1(text: "Giriş Yap"),
                      const SizedBox(height: 40),

                      Rateflagtextfield(
                        controller: emailController,
                        label: "E-posta giriniz",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),

                      const SizedBox(height: 40),

                      Rateflagtextfield(
                        controller: passwordController,
                        label: "Şifre giriniz",
                        icon: Icons.password_outlined,
                        isPassword: true,
                        validator: Validators.password,
                        keyboardType: TextInputType.visiblePassword,
                      ),

                      const SizedBox(height: 60),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Onboardingelevetedbutton.primary(
                            text: isLoading
                                ? "Giriş yapılıyor..."
                                : "Giriş yap",
                            onPressed: isLoading ? null : onLoginPressed,
                          ),
                          Onboardingelevetedbutton.secondary(
                            text: isResetLoading
                                ? "Şifre Unutuluyor..."
                                : "Şifremi Unuttum",
                            onPressed: onForgotPasswordPressed,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      Logintextbutton(
                        text: "Hesabın yok mu? Kayıt ol",
                        onPressed: onRegisterPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
