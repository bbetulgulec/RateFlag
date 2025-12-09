import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final mailController = TextEditingController();
    final dateController = TextEditingController();
    final passwordController = TextEditingController();
    final repeatPasswordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 30),
                  Rateflagtext.Maintitle(text: "Kayıt ol"),
                  const SizedBox(height: 30),

                  /// İsim
                  Rateflagtextfield(
                    controller: firstNameController,
                    label: "İsim :",
                    keyboardType: TextInputType.text,
                    validator: Validators.onlyLetters,
                  ),
                  const SizedBox(height: 30),

                  /// Soyisim
                  Rateflagtextfield(
                    controller: lastNameController,
                    label: "Soyisim :",
                    keyboardType: TextInputType.text,
                    validator: Validators.onlyLetters,
                  ),
                  const SizedBox(height: 30),

                  /// Mail
                  Rateflagtextfield(
                    controller: mailController,
                    label: "E-posta :",
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 30),

                  /// Doğum Tarihi (DateTime)
                  Rateflagtextfield(
                    controller: dateController,
                    label: "Doğum Tarihi (YYYY-MM-DD) :",
                    keyboardType: TextInputType.datetime,
                    isDateField: true,
                    validator: Validators.date,
                    onDateSelected: (date) {
                      cubit.setBirthDate(date);
                    },
                  ),
                  const SizedBox(height: 30),

                  /// Şifre
                  Rateflagtextfield(
                    controller: passwordController,
                    label: "Şifre :",
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 30),

                  /// Şifre tekrar
                  Rateflagtextfield(
                    controller: repeatPasswordController,
                    label: "Şifre (Tekrar) :",
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validators.passwordMatch(
                      value,
                      passwordController.text,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// Giriş ekranına dön
                      Onboardingelevetedbutton.secondary(
                        text: "Zaten hesabım var",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      /// Kayıt ol butonu
                      BlocConsumer<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          return Onboardingelevetedbutton.primary(
                            text: state.isRegisterLoading
                                ? "Kaydediliyor..."
                                : "Kayıt ol",
                            onPressed: state.isRegisterLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      /// Doğum tarihini DateTime’a çevir
                                      final birthDate = DateTime.parse(
                                        dateController.text.trim(),
                                      );
                                      cubit.setBirthDate(birthDate);

                                      cubit.register(
                                        firstNameController.text.trim(),
                                        lastNameController.text.trim(),
                                        mailController.text.trim(),
                                        birthDate,
                                        passwordController.text.trim(),
                                      );
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                          );
                        },
                        listener: (context, state) {
                          if (!state.isEmailVerified &&
                              state.errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("E-posta doğrulaması gerekli!"),
                              ),
                            );
                          }

                          if (state.isRegisterSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Kayıt başarılı!")),
                            );
                          }
                          if (state.errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage!)),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
