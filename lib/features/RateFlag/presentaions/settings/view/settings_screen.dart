import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/view/account_info_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/functions/show_delete_dialog.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/functions/show_setting_dialog.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/setting_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShowSettingDialog showSettingDialog = ShowSettingDialog();
    ShowDeleteDialog showDeleteDialog = ShowDeleteDialog();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: AlignmentGeometry.topLeft,
          child: RateFlagText.head2(text: "Ayarlar"),
        ),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isSignOutLoading) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: RateFlagText.fadedItalic(text: "Destek"),
                ),
                const SizedBox(height: 25),
                SettingCard(
                  icon: Icons.description_outlined,
                  iconColor: Colors.deepPurple,
                  title: "Terms of Service",
                  onTap: () {
                    showSettingDialog.showSettingDialog(
                      context,
                      "Terms of Service",
                      "1. This app is provided “as is” without warranties.\n2. Users are responsible for content shared in the app.\n3. Premium purchases are non-refundable unless required by law.\n4. Misuse may result in account suspension.\n5. Using the app means you accept the latest Terms.",
                    );
                  },
                ),
                const SizedBox(height: 15),

                SettingCard(
                  icon: Icons.lock_outline,
                  iconColor: Colors.deepPurple,
                  title: "Privacy Policy",
                  onTap: () {
                    showSettingDialog.showSettingDialog(
                      context,
                      "Privacy Policy",
                      """
• We collect basic analytics to improve the app.
• Personal information is stored securely.
• We do not sell your data to third parties.
• You may request data deletion at any time.
""",
                    );
                  },
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: RateFlagText.fadedItalic(text: "Hesap"),
                ),
                const SizedBox(height: 25),

                SettingCard(
                  icon: Icons.settings_accessibility,
                  iconColor: Colors.deepPurple,
                  title: "Hesap Bilgileri güncelle",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountInfoScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                SettingCard(
                  icon: Icons.exit_to_app,
                  iconColor: Colors.deepPurple,
                  title: "Çıkıs yap",
                  onTap: () {
                    showDeleteDialog.showDeleteDialog(
                      context,
                      "Çıkış yap",
                      "Çıkış yapılsın mı ?",
                      () {
                        context.read<SettingsCubit>().signOut();

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
        listener: (context, state) {
          try {
            if (state.isSignOutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("başarı ile çıkış yapıldı")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          } catch (e) {
            if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          }
        },
      ),
    );
  }
}
