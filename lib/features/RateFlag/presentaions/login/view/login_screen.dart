import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/loginButton.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/loginTextButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Rateflagtext.Maintitle(text: "Giriş Yap"),
            const SizedBox(height: 60),

            Rateflagtextfield(
              controller: emailController,
              label: "E-posta giriniz",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            Rateflagtextfield(
              controller: passwordController,
              label: "Şifre giriniz",
              icon: Icons.password_outlined,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.password,
            ),

            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Onboardingelevetedbutton.primary(
                  text: "Giriş yap",
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                Onboardingelevetedbutton.secondary(
                  text: "Şifremi Unuttum",
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),
            Rateflagtext.Maintitle(text: "Diğer giriş yöntemleri"),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Loginbutton(imagePath: "assets/images/google.png"),
                const SizedBox(width: 40),
                Loginbutton(imagePath: "assets/images/github-sign.png"),
              ],
            ),
            const SizedBox(height: 30),
            Logintextbutton(text: "Zaten hesabım var"),
          ],
        ),
      ),
    );
  }
}
