import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/loginButton.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/widget/loginTextButton.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/view/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final cubit = context.read<LoginCubit>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
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
                    validator: Validators.email,
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
                        text: state.isLoginLoading
                            ? "Giriş yapılıyor ..."
                            : "Giriş yap",
                        onPressed: state.isLoginLoading
                            ? null
                            : () async {
                                // Form validator
                                if (!formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Lütfen tüm alanları doğru doldurun",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  // login fonksiyonunu çağır ve sonucu bekle
                                  await cubit.login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );

                                  // Login başarılıysa MainScreen'e git
                                  if (cubit.state.isLoginSuccess) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainScreen(),
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  String message = "";
                                  if (e.code == 'invalid-email') {
                                    message = "Geçerli bir e-posta giriniz";
                                  } else if (e.code == 'user-not-found') {
                                    message = "Bu e-posta ile kayıt bulunamadı";
                                  } else if (e.code == 'wrong-password') {
                                    message = "Şifre yanlış";
                                  } else if (e.code == 'invalid-credential') {
                                    message =
                                        "Giriş bilgileri geçersiz veya süresi dolmuş";
                                  } else {
                                    message = e.message ?? "Bir hata oluştu";
                                  }

                                  // Hata mesajını göster
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },
                      ),

                      const SizedBox(height: 20),
                      Onboardingelevetedbutton.secondary(
                        text: "Şifremi Unuttum",
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Rateflagtext.Maintitle(text: "Diğer giriş yöntemleri"),
                      Loginbutton(imagePath: "assets/images/google.png"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Logintextbutton(
                    text: "Hesabın yok mu? Kayıt ol",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.isLoginLoading) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Yükleniyor")));
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
      ),
    );
  }
}
