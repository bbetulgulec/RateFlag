import 'package:flutter/material.dart';

class Rateflagtextfield extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final IconData? icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;

  const Rateflagtextfield({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    required this.keyboardType,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<Rateflagtextfield> createState() => _RateflagtextfieldState();
}

class _RateflagtextfieldState extends State<Rateflagtextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,

        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: Colors.grey[600])
            : null,

        labelStyle: TextStyle(color: Colors.grey[900]),
        filled: false,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
        ),

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
