import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class CommunTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  // Opsiyonel
  final bool isLoading;
  final Color? color;

  const CommunTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              text,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
                color: color ?? colors.onSurface,
              ),
            ),
    );
  }
}
