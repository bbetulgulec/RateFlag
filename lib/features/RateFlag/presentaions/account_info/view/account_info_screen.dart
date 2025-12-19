import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/custom_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/functions/show_delete_dialog.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountInfoCubit>();
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final showDeleteDialog = ShowDeleteDialog();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!cubit.state.isGetInfoSuccess && !cubit.state.isGetInfoLoading) {
        cubit.loadUser(userID);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RateFlagText.head2(text: "Profil Güncelleme"),
      ),
      body: BlocConsumer<AccountInfoCubit, AccountInfoState>(
        listener: (context, state) {
          if (state.isUpdateInfoSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Bilgiler güncellendi")),
            );
          }

          if (state.isDeleteAccountSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Kullanıcı silindi")));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.isGetInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: cubit.firstNameController,
                  label: "İsim :",
                  validator: Validators.onlyLetters,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: cubit.lastNameController,
                  label: "Soyisim :",
                  validator: Validators.onlyLetters,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: cubit.mailController,
                  label: "E-posta :",
                  validator: Validators.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: cubit.dateController,
                  label: "Doğum Tarihi :",
                  validator: Validators.date,
                  keyboardType: TextInputType.datetime,
                  isDateField: true,
                ),

                const SizedBox(height: 40),

                CustomElevatedButton.primary(
                  text: state.isUpdateInfoLoading
                      ? "Güncelleniyor..."
                      : "Bilgileri Kaydet",
                  onPressed: state.isUpdateInfoLoading
                      ? null
                      : () => cubit.updateUser(userID),
                ),

                const SizedBox(height: 20),

                CustomElevatedButton.secondary(
                  text: "Hesap Sil",
                  onPressed: () {
                    showDeleteDialog.showDeleteDialog(
                      context,
                      "Hesap Silme",
                      "Hesabını silmek istediğine emin misin?",
                      () => cubit.deleteUser(userID),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
