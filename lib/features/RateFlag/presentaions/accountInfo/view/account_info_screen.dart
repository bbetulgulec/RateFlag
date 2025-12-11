import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/show_setting_dialog.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<AccountInfoCubit>();

    final userID = FirebaseAuth.instance.currentUser!.uid;

    /// SAYFA AÇILIR AÇILMAZ VERİ ÇEKİLİYOR
    cubit.loadUser(userID);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountInfoCubit>();

    final userID = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Rateflagtext.Maintitle(text: "Profil Güncelleme")),
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
                  isDateField: true,
                  keyboardType: TextInputType.datetime,
                  onDateSelected: (date) {
                    cubit.setBirthDate(date);
                  },
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

                Onboardingelevetedbutton.primary(
                  text: "Hesap Sil",
                  onPressed: () {
                    showDeleteDialog(
                      context,
                      "Hesap Silme",
                      "Hesap silmeyi onaylıyor musun?",
                      () {
                        cubit.deleteUser(userID);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
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
