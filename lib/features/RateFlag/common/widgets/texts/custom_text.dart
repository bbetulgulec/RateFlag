import 'package:flutter/material.dart';

class RateFlagText extends StatelessWidget {
  final String text;
  final bool isItalic;
  final bool isBold;
  final Color color;
  final double fontSize;

  const RateFlagText({
    super.key,
    required this.text,
    this.isItalic = false,
    this.isBold = false,
    required this.color,
    this.fontSize = 16,
  });

  /// Faded Italic
  factory RateFlagText.fadedItalic({Key? key, required String text}) {
    return RateFlagText(
      key: key,
      text: text,
      isItalic: true,
      color: Colors.black54,
    );
  }

  /// Head1
  factory RateFlagText.head1({Key? key, required String text}) {
    return RateFlagText(
      key: key,
      text: text,
      isBold: true,
      fontSize: 28,
      color: Colors.deepPurple,
    );
  }

  /// Head2
  factory RateFlagText.head2({Key? key, required String text}) {
    return RateFlagText(
      key: key,
      text: text,
      isBold: true,
      fontSize: 24,
      color: Colors.black87,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
      ),
    );
  }
}
