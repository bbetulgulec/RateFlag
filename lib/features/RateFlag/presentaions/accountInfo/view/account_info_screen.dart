import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/common/widget/toast_message.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/functions/show_delete_dialog.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountInfoCubit>();
    final showDeleteDialog = ShowDeleteDialog();

    final userID = FirebaseAuth.instance.currentUser!.uid;
    cubit.loadUser(userID);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RateFlagText.head2(text: "Profil Güncelleme"),
      ),
      body: BlocConsumer<AccountInfoCubit, AccountInfoState>(
        listener: (context, state) {
          if (state.isUpdateInfoSuccess) {
            ToastMessage.show(context, message: " Bilgiler güncellendi ");
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
        },
        builder: (context, state) {
          if (state.isGetInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Rateflagtextfield(
                  controller: cubit.firstNameController,
                  label: "İsim :",
                  validator: Validators.onlyLetters,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                Rateflagtextfield(
                  controller: cubit.lastNameController,
                  label: "Soyisim :",
                  validator: Validators.onlyLetters,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                Rateflagtextfield(
                  controller: cubit.mailController,
                  label: "E-posta :",
                  validator: Validators.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                Rateflagtextfield(
                  controller: cubit.dateController,
                  label: "Doğum Tarihi :",
                  validator: Validators.date,
                  keyboardType: TextInputType.datetime,
                  isDateField: true,
                  onDateSelected: cubit.setBirthDate,
                ),
                const SizedBox(height: 40),

                Onboardingelevetedbutton.primary(
                  text: state.isUpdateInfoLoading
                      ? "Güncelleniyor..."
                      : "Bilgileri Kaydet",
                  onPressed: () {
                    cubit.updateUser(userID);
                  },
                ),

                const SizedBox(height: 20),

                Onboardingelevetedbutton.secondary(
                  text: "Hesap Sil",
                  onPressed: () {
                    showDeleteDialog.showDeleteDialog(
                      context,
                      "Hesap Silme",
                      "Hesap silmeyi onaylıyor musun?",
                      () {
                        cubit.deleteUser(userID);
                      },
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
