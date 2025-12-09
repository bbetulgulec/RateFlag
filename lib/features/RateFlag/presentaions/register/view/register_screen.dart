import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidgetText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController mailController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordController =
        TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Rateflagtext.Maintitle(text: "Kayıt ol"),
                //İsim
                Rateflagtextfield(
                  controller: firstNameController,
                  label: "İsim :",
                  keyboardType: TextInputType.text,
                  validator: Validators.onlyLetters,
                ),
                //Soyisim
                Rateflagtextfield(
                  controller: lastNameController,
                  label: "Soyisim :",
                  keyboardType: TextInputType.text,
                  validator: Validators.onlyLetters,
                ),
                //Mail
                Rateflagtextfield(
                  controller: mailController,
                  label: "E-posta :",
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                //Yaş
                Rateflagtextfield(
                  controller: dateController,
                  label: "Yaş :",
                  keyboardType: TextInputType.datetime,
                  //////////////////////////////////////////////////validator: Validators,
                ),
                //Şifre
                Rateflagtextfield(
                  controller: passwordController,
                  label: "Şifre :",
                  keyboardType: TextInputType.visiblePassword,
                  validator: Validators.password,
                ),
                //şifre tekrarı
                Rateflagtextfield(
                  controller: repeatPasswordController,
                  label: "Şifre (Tekrar) :",
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) =>
                      Validators.passwordMatch(value, passwordController.text),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Giriş sayfasıan gider
                    Onboardingelevetedbutton.secondary(
                      text: "Zaten hesabım var",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    //Kayıt ol
                    Onboardingelevetedbutton.primary(
                      text: "Kayıt ol",
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
