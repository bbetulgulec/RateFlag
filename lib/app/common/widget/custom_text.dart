import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

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

  factory RateFlagText.fadedItalic({
    Key? key,
    required String text,
    required BuildContext context,
  }) {
    return RateFlagText(
      key: key,
      text: text,

      isItalic: true,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(60),
    );
  }

  /// Head1
  factory RateFlagText.head1({
    Key? key,
    required String text,
    required BuildContext context,
  }) {
    return RateFlagText(
      key: key,
      text: text,
      isBold: true,
      fontSize: 28.sp,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  /// Head2
  factory RateFlagText.head2({
    Key? key,
    required String text,
    required BuildContext context,
  }) {
    return RateFlagText(
      key: key,
      text: text,
      isBold: true,
      fontSize: 24.sp,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  factory RateFlagText.head3({
    Key? key,
    required String text,
    required BuildContext context,
  }) {
    return RateFlagText(
      key: key,
      text: text,
      isBold: true,
      fontSize: 14.sp,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  factory RateFlagText.head4({
    Key? key,
    required String text,
    required BuildContext context,
  }) {
    return RateFlagText(
      key: key,
      text: text,
      isBold: true,
      fontSize: 12.sp,
      color: Theme.of(context).colorScheme.onSurface,
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
