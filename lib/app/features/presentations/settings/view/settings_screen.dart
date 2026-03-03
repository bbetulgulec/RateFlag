import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/get_it/service_locator.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/common/widget/custom_text.dart';
import 'package:rate_flag/app/features/presentations/login/cubit/login_cubit.dart';
import 'package:rate_flag/app/features/presentations/login/view/login_screen.dart';
import 'package:rate_flag/app/features/presentations/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/app/features/presentations/settings/cubit/settings_state.dart';
import 'package:rate_flag/app/common/widget/dialog/common_delete_confirm_dialog.dart';
import 'package:rate_flag/app/features/presentations/settings/widget/setting_dialog.dart';
import 'package:rate_flag/app/features/presentations/settings/widget/setting_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: AlignmentGeometry.topLeft,
          child: RateFlagText.head2(
            text: TextConstants.setting,
            context: context,
          ),
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
                    text: TextConstants.support,
                    context: context,
                  ),
                ),
                SizedBox(height: 25.h),

                SettingCard(
                  icon: Icons.description_outlined,
                  iconColor: Colors.deepPurple,
                  title: TextConstants.termService,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => const SettingDialog(
                        title: TextConstants.termService,
                        content: TextConstants.termServiceData,
                      ),
                    );
                  },
                ),

                SizedBox(height: 15.h),

                SettingCard(
                  icon: Icons.lock_outline,
                  iconColor: Colors.deepPurple,
                  title: TextConstants.privacyPolicy,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => const SettingDialog(
                        title: TextConstants.privacyPolicy,
                        content: TextConstants.privacyPolicyData,
                      ),
                    );
                  },
                ),

                SizedBox(height: 25.h),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: RateFlagText.fadedItalic(
                    text: TextConstants.account,
                    context: context,
                  ),
                ),
                SizedBox(height: 25.h),

                SettingCard(
                  icon: Icons.settings_accessibility,
                  iconColor: Colors.deepPurple,
                  title: TextConstants.updateAccount,
                  onTap: () {
                    Routes.push(context, Routes.accountInfo);
                  },
                ),
                SizedBox(height: 15.h),
                SettingCard(
                  icon: Icons.exit_to_app,
                  iconColor: Colors.deepPurple,
                  title: TextConstants.logout,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => DeleteConfirmDialog(
                        title: TextConstants.logout,
                        content: TextConstants.logoutQuiz,
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
                SnackBar(content: Text(TextConstants.successLogout)),
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
