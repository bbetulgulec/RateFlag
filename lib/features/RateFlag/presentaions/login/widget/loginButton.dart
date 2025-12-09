import 'package:flutter/material.dart';

class Loginbutton extends StatelessWidget {
  final String imagePath;
  const Loginbutton({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.12;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45, width: 1.5),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
