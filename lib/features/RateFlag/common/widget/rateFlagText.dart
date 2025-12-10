import 'package:flutter/material.dart';

class Rateflagtext extends StatelessWidget {
  final String text;
  final bool isFadedItalic;
  final bool boldText;

  const Rateflagtext({
    super.key,
    required this.text,
    this.isFadedItalic = false,
    this.boldText = false,
  });

  factory Rateflagtext.fadedItalic({Key? key, required String text}) {
    return Rateflagtext(
      key: key,
      text: text,
      isFadedItalic: true,
      boldText: false,
    );
  }

  factory Rateflagtext.Maintitle({Key? key, required String text}) {
    return Rateflagtext(
      text: text,
      key: key,
      isFadedItalic: false,
      boldText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: isFadedItalic ? Colors.black54 : Colors.black87,
        fontStyle: isFadedItalic ? FontStyle.italic : FontStyle.normal,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.normal,
      ),
    );
  }
}
