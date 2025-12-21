import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,

      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.isDateField,
      maxLength: widget.maxLength,
      maxLines: widget.isPassword ? 1 : (widget.maxLines ?? 1),
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      onChanged: widget.onChanged,

      onTap: widget.isDateField ? _pickDate : null,

      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,

        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }

  Future<void> _pickDate() async {
    FocusScope.of(context).unfocus();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      widget.controller?.text = pickedDate.toIso8601String().split("T").first;

      widget.onDateSelected?.call(pickedDate);
    }
  }
}
