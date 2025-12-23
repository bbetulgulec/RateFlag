import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';

class RegisterDatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const RegisterDatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(30),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          selectedDate == null
              ? TextConstants.selectYourBirthday
              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
