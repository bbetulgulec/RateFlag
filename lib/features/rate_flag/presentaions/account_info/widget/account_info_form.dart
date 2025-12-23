import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/utils/validators/validators.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/widget/register_gender_radio_group.dart';
import 'package:rate_flag/features/RateFlag/domain/model/user.dart';

class AccountInfoFormWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final Gender? gender;
  final TextEditingController birthDateController;
  final bool isLoading;

  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<DateTime> onBirthDateSelected;
  final ValueChanged<Gender?> onGenderChanged;
  final VoidCallback onSavePressed;
  final VoidCallback onDeletePressed;
  const AccountInfoFormWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDateController,
    required this.isLoading,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onEmailChanged,
    required this.onBirthDateSelected,
    required this.onGenderChanged,
    required this.onSavePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            CustomTextField(
              initialValue: firstName,

              label: TextConstants.firstName,
              validator: Validators.onlyLetters,
              keyboardType: TextInputType.text,
              onChanged: onFirstNameChanged,
            ),

            SizedBox(height: 16.h),

            CustomTextField(
              initialValue: lastName,
              label: TextConstants.lastName,
              validator: Validators.onlyLetters,
              keyboardType: TextInputType.text,
              onChanged: onLastNameChanged,
            ),

            SizedBox(height: 16.h),

            CustomTextField(
              initialValue: email,
              label: TextConstants.email,
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: onEmailChanged,
            ),

            SizedBox(height: 16.h),

            CustomTextField(
              controller: birthDateController,
              label: TextConstants.birthDateLabel,
              isDateField: true,
              keyboardType: TextInputType.datetime,
              validator: Validators.date,
              onDateSelected: onBirthDateSelected,
            ),

            SizedBox(height: 16.h),

            GenderRadioGroup(
              selectedGender: gender,
              onChanged: onGenderChanged,
            ),

            SizedBox(height: 32.h),

            CustomElevatedButton.primary(
              text: isLoading
                  ? TextConstants.updating
                  : TextConstants.saveOfInfo,
              onPressed: isLoading ? null : onSavePressed,
            ),

            SizedBox(height: 16.h),

            CustomElevatedButton.secondary(
              text: TextConstants.deleteAccount,
              onPressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}
