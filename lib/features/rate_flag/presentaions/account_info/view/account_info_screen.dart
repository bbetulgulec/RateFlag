import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/dialog/common_delete_confirm_dialog.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/rate_flag/core/enum/request_status.dart';
import 'package:rate_flag/features/rate_flag/presentaions/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/account_info/cubit/account_info_state.dart';
import 'package:rate_flag/features/rate_flag/presentaions/account_info/widget/account_info_form.dart';

class AccountInfoScreen extends StatelessWidget {
  AccountInfoScreen({super.key});

  final TextEditingController birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountInfoCubit>();
    final userID = FirebaseAuth.instance.currentUser!.uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state.getInfoStatus == RequestStatus.initial) {
        cubit.loadUser(userID);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: RateFlagText.head2(
          text: TextConstants.profileUpdateTitle,
          context: context,
        ),
      ),
      body: BlocConsumer<AccountInfoCubit, AccountInfoState>(
        listener: (context, state) {
          if (state.getInfoStatus == RequestStatus.success &&
              state.isFormInitialized &&
              state.birthDate != null &&
              birthDateController.text.isEmpty) {
            birthDateController.text = state.birthDate!
                .toIso8601String()
                .split('T')
                .first;
          }

          if (state.updateInfoStatus == RequestStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(TextConstants.infoUpdated)),
            );
          }

          if (state.deleteAccountStatus == RequestStatus.success) {
            Routes.clearAndPush(context, Routes.login);
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },

        builder: (context, state) {
          return Stack(
            children: [
              AccountInfoFormWidget(
                key: ValueKey(state.isFormInitialized),
                firstName: state.firstName,
                lastName: state.lastName,
                email: state.email,
                gender: state.gender,
                birthDateController: birthDateController,
                isLoading: state.updateInfoStatus == RequestStatus.loading,

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
                      title: TextConstants.deleteAccountTitle,
                      content: TextConstants.deleteAccountContent,
                      onConfirm: () {
                        cubit.deleteUser(userID);
                      },
                    ),
                  );
                },
              ),

              if (state.getInfoStatus == RequestStatus.loading)
                Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withAlpha(77),
                  child: const Center(child: CircularProgressIndicator()),
                ),

              if (state.updateInfoStatus == RequestStatus.loading)
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
