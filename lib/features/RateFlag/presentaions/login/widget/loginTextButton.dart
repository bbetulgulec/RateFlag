import 'package:flutter/material.dart';

class Logintextbutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const Logintextbutton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}
