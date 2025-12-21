import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

class GenderRadioGroup extends StatelessWidget {
  const GenderRadioGroup({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<Gender?>(
      groupValue: selectedGender,
      onChanged: onChanged,
      child: Row(
        children: [
          Expanded(
            child: RadioListTile<Gender?>(
              title: const Text("Kadın"),
              value: Gender.female,
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: RadioListTile<Gender?>(
              title: const Text("Erkek"),
              value: Gender.male,
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
