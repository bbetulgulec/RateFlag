import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.dateController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.isLoading,
    required this.onBirthDateSelected,
    required this.onRegisterPressed,
    required this.onAlreadyHaveAccount,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  final bool isLoading;

  final ValueChanged<DateTime> onBirthDateSelected;
  final VoidCallback onRegisterPressed;
  final VoidCallback onAlreadyHaveAccount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RateFlagText.head1(text: "Kayıt ol"),
          const SizedBox(height: 30),

          Rateflagtextfield(
            controller: firstNameController,
            label: "İsim",
            validator: Validators.onlyLetters,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),

          Rateflagtextfield(
            controller: lastNameController,
            label: "Soyisim",
            validator: Validators.onlyLetters,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),

          Rateflagtextfield(
            controller: emailController,
            label: "E-posta",
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          const SizedBox(height: 20),

          Rateflagtextfield(
            controller: dateController,
            label: "Doğum Tarihi (YYYY-MM-DD)",
            isDateField: true,
            validator: Validators.date,
            onDateSelected: onBirthDateSelected,
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 20),

          Rateflagtextfield(
            controller: passwordController,
            label: "Şifre",
            isPassword: true,
            validator: Validators.password,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),

          Rateflagtextfield(
            controller: repeatPasswordController,
            label: "Şifre (Tekrar)",
            isPassword: true,
            validator: (value) =>
                Validators.passwordMatch(value, passwordController.text),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Onboardingelevetedbutton.secondary(
                text: "Zaten hesabım var",
                onPressed: onAlreadyHaveAccount,
              ),
              Onboardingelevetedbutton.primary(
                text: isLoading ? "Kaydediliyor..." : "Kayıt ol",
                onPressed: isLoading ? null : onRegisterPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
