import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/widget/account_info_form.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/dialog/common_delete_confirm_dialog.dart';

class AccountInfoScreen extends StatelessWidget {
  AccountInfoScreen({super.key});

  final TextEditingController birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountInfoCubit>();
    final userID = FirebaseAuth.instance.currentUser!.uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!cubit.state.isGetInfoSuccess && !cubit.state.isGetInfoLoading) {
        cubit.loadUser(userID);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: RateFlagText.head2(text: "Profil Güncelleme", context: context),
      ),
      body: BlocConsumer<AccountInfoCubit, AccountInfoState>(
        listener: (context, state) {
          if (state.isUpdateInfoSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Bilgiler güncellendi")),
            );
          }

          if (state.isDeleteAccountSuccess) {
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

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.birthDate != null) {
            birthDateController.text = state.birthDate!
                .toIso8601String()
                .split("T")
                .first;
          }

          return Stack(
            children: [
              AccountInfoFormWidget(
                key: ValueKey(
                  '${state.firstName}-${state.lastName}-${state.email}-${state.gender}',
                ),
                firstName: state.firstName,
                lastName: state.lastName,
                email: state.email,
                gender: state.gender,
                birthDateController: birthDateController,
                isLoading: state.isUpdateInfoLoading,

                onFirstNameChanged: cubit.firstNameChanged,
                onLastNameChanged: cubit.lastNameChanged,
                onEmailChanged: cubit.emailChanged,
                onBirthDateSelected: cubit.birthDateChanged,
                onGenderChanged: (gender) {
                  if (gender != null) {
                    cubit.genderChanged(gender);
                  }
                },

                onSavePressed: () => cubit.updateUser(userID),
                onDeletePressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => DeleteConfirmDialog(
                      title: "Hesap Sil",
                      content: "Hesabını silmek istediğine emin misin?",
                      onConfirm: () {
                        cubit.deleteUser(userID);
                      },
                    ),
                  );
                },
              ),
              if (state.isUpdateInfoLoading)
                Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withAlpha(77),

                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
