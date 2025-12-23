import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/domain/model/user.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/widget/register_gender_radio_group.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    super.key,
    required this.formKey,
    required this.isLoading,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onChanged,
    required this.selectedGender,
    required this.birthDateController,

    required this.onRepeatPasswordChanged,
    required this.onBirthDateSelected,
    required this.onRegisterPressed,
    required this.onAlreadyHaveAccount,
  });

  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onRepeatPasswordChanged;
  final ValueChanged<DateTime> onBirthDateSelected;

  final TextEditingController birthDateController;

  final VoidCallback onRegisterPressed;
  final VoidCallback onAlreadyHaveAccount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RateFlagText.head1(text: TextConstants.register, context: context),
          SizedBox(height: 30.h),

          CustomTextField(
            label: TextConstants.firstName,
            keyboardType: TextInputType.text,
            validator: Validators.onlyLetters,
            onChanged: onFirstNameChanged,
          ),
          SizedBox(height: 20.h),

          CustomTextField(
            label: TextConstants.lastName,
            keyboardType: TextInputType.text,
            validator: Validators.onlyLetters,
            onChanged: onLastNameChanged,
          ),
          SizedBox(height: 20.h),

          CustomTextField(
            label: TextConstants.email,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
            onChanged: onEmailChanged,
          ),
          SizedBox(height: 20.h),

          CustomTextField(
            controller: birthDateController,

            label: TextConstants.birthDay,
            isDateField: true,
            keyboardType: TextInputType.datetime,
            validator: Validators.date,
            onDateSelected: onBirthDateSelected,
          ),
          SizedBox(height: 20.h),

          GenderRadioGroup(
            selectedGender: selectedGender,
            onChanged: onChanged,
          ),

          CustomTextField(
            label: TextConstants.password,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            validator: Validators.password,
            onChanged: onPasswordChanged,
          ),
          SizedBox(height: 20.h),

          CustomTextField(
            label: TextConstants.passwordAgain,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            validator: Validators.password,
            onChanged: onRepeatPasswordChanged,
          ),
          SizedBox(height: 30.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton.secondary(
                text: TextConstants.iHaveAlreadyAccount,
                onPressed: onAlreadyHaveAccount,
              ),
              CustomElevatedButton.primary(
                text: isLoading
                    ? TextConstants.registiring
                    : TextConstants.register,
                onPressed: isLoading ? null : onRegisterPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
