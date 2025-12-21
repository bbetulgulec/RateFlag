import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/view/account_info_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_state.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/dialog/common_delete_confirm_dialog.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/setting_dialog.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/setting_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: AlignmentGeometry.topLeft,
          child: RateFlagText.head2(text: "Ayarlar", context: context),
        ),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isSignOutLoading) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: RateFlagText.fadedItalic(
                    text: "Destek",
                    context: context,
                  ),
                ),
                SizedBox(height: 25.h),

                SettingCard(
                  icon: Icons.description_outlined,
                  iconColor: Colors.deepPurple,
                  title: "Terms of Service",
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => const SettingDialog(
                        title: "Terms of Service",
                        content:
                            "1. This app is provided “as is” without warranties.\n2. Users are responsible for content shared in the app.\n3. Premium purchases are non-refundable unless required by law.\n4. Misuse may result in account suspension.\n5. Using the app means you accept the latest Terms.",
                      ),
                    );
                  },
                ),

                SizedBox(height: 15.h),

                SettingCard(
                  icon: Icons.lock_outline,
                  iconColor: Colors.deepPurple,
                  title: "Privacy Policy",
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => const SettingDialog(
                        title: "Privacy Policy",
                        content: """
• We collect basic analytics to improve the app.
• Personal information is stored securely.
• We do not sell your data to third parties.
• You may request data deletion at any time.
""",
                      ),
                    );
                  },
                ),

                SizedBox(height: 25.h),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: RateFlagText.fadedItalic(
                    text: "Hesap",
                    context: context,
                  ),
                ),
                SizedBox(height: 25.h),

                SettingCard(
                  icon: Icons.settings_accessibility,
                  iconColor: Colors.deepPurple,
                  title: "Hesap Bilgileri güncelle",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => getIt<AccountInfoCubit>(),
                          child: AccountInfoScreen(),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15.h),
                SettingCard(
                  icon: Icons.exit_to_app,
                  iconColor: Colors.deepPurple,
                  title: "Çıkış yap",
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => DeleteConfirmDialog(
                        title: "Çıkış yap",
                        content: "Çıkış yapılsın mı ?",
                        onConfirm: () {
                          context.read<SettingsCubit>().signOut();
                        },
                      ),
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
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (_) => getIt<LoginCubit>(),
                    child: LoginScreen(),
                  ),
                ),
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
