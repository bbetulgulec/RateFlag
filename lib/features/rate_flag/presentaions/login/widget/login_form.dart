import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/commun_text_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.isLoading,
    required this.isResetLoading,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onRegisterPressed,
  });

  final bool isLoading;
  final bool isResetLoading;

  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;

  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RateFlagText.head1(text: TextConstants.login, context: context),
            SizedBox(height: 60.h),

            CustomTextField(
              label: TextConstants.email,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
              onChanged: onEmailChanged,
            ),

            SizedBox(height: 24.h),

            CustomTextField(
              label: TextConstants.password,
              icon: Icons.lock_outline,
              isPassword: true,
              validator: Validators.password,
              onChanged: onPasswordChanged,
              keyboardType: TextInputType.visiblePassword,
            ),

            SizedBox(height: 40.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton.primary(
                  text: isLoading
                      ? TextConstants.logining
                      : TextConstants.login,
                  onPressed: isLoading ? null : onLoginPressed,
                ),
                CustomElevatedButton.secondary(
                  text: isResetLoading
                      ? TextConstants.sending
                      : TextConstants.forgotPassword,
                  onPressed: isResetLoading ? null : onForgotPasswordPressed,
                ),
              ],
            ),

            SizedBox(height: 40.h),

            CommunTextButton(
              text: "Hesabın yok mu? Kayıt ol",
              onPressed: onRegisterPressed,
            ),
          ],
        ),
      ),
    );
  }
}
