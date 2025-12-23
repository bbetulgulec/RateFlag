import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/widget/register_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) =>
            previous.isRegisterSuccess != current.isRegisterSuccess,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.isRegisterSuccess) {
            Navigator.push(
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
          final cubit = context.read<RegisterCubit>();
          if (state.birthDate != null) {
            _birthDateController.text = state.birthDate!
                .toIso8601String()
                .split("T")
                .first;
          }

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
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.h),
                            child: RegisterFormWidget(
                              formKey: _formKey,
                              isLoading: state.isRegisterLoading,

                              selectedGender: state.gender,
                              birthDateController: _birthDateController,

                              onFirstNameChanged: cubit.firstNameChanged,
                              onLastNameChanged: cubit.lastNameChanged,
                              onEmailChanged: cubit.emailChanged,
                              onPasswordChanged: cubit.passwordChanged,
                              onRepeatPasswordChanged: (_) {},

                              onBirthDateSelected: cubit.setBirthDate,

                              onChanged: (gender) {
                                if (gender != null) cubit.setGender(gender);
                              },

                              onRegisterPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                cubit.register();
                              },

                              onAlreadyHaveAccount: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (state.isRegisterLoading)
                Container(
                  color: Theme.of(context).colorScheme.surface.withAlpha(77),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
