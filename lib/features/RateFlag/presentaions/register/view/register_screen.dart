import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/widget/register_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.isRegisterSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Kayıt başarılı!")));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => getIt<LoginCubit>(),
                  child: LoginScreen(),
                ),
              ),
            );
          }

          if (!state.isEmailVerified && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("E-posta doğrulaması gerekli!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => getIt<LoginCubit>(),
                  child: LoginScreen(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              AbsorbPointer(
                absorbing: state.isRegisterLoading,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RegisterFormWidget(
                            formKey: _formKey,
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            emailController: _emailController,
                            dateController: _dateController,
                            passwordController: _passwordController,
                            repeatPasswordController: _repeatPasswordController,
                            isLoading: state.isRegisterLoading,
                            onBirthDateSelected: cubit.setBirthDate,
                            onAlreadyHaveAccount: () {
                              Navigator.pop(context);
                            },
                            onRegisterPressed: () {
                              if (!_formKey.currentState!.validate()) return;

                              final birthDate = DateTime.parse(
                                _dateController.text.trim(),
                              );

                              cubit.register(
                                _firstNameController.text.trim(),
                                _lastNameController.text.trim(),
                                _emailController.text.trim(),
                                birthDate,
                                _passwordController.text.trim(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (state.isRegisterLoading)
                Container(
                  color: Colors.black.withAlpha(77),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
