import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common_text_field_cubit.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isDateField;
  final Function(DateTime)? onDateSelected;
  final Function(String)? onChanged;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final String? initialValue;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.icon,
    required this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.isDateField = false,
    this.onDateSelected,
    this.onChanged,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomTextFieldCubit(),
      child: BlocBuilder<CustomTextFieldCubit, CommonTextFieldCubit>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            initialValue: controller == null ? initialValue : null,
            keyboardType: keyboardType,
            readOnly: isDateField,
            maxLength: maxLength,
            maxLines: isPassword ? 1 : (maxLines ?? 1),
            obscureText: isPassword ? state.obscureText : false,
            validator: validator,
            onChanged: onChanged,
            onTap: isDateField ? () => _pickDate(context) : null,
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              prefixIcon: icon != null ? Icon(icon) : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        state.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        context.read<CustomTextFieldCubit>().toggleObscure();
                      },
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      controller?.text = pickedDate.toIso8601String().split("T").first;

      onDateSelected?.call(pickedDate);
    }
  }
}
