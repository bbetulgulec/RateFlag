import 'package:flutter/material.dart';
import 'package:rate_flag/app/common/constants/app_color.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class FlagButton extends StatelessWidget {
  final bool isGreen;
  final int count;
  final bool hasFlagged;
  final VoidCallback onPressedCallback;

  const FlagButton({
    super.key,
    required this.isGreen,
    required this.count,
    required this.hasFlagged,
    required this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: hasFlagged ? null : onPressedCallback,
          icon: Icon(
            Icons.flag,
            color: isGreen
                ? (hasFlagged
                      ? AppColors.greenFlag
                      : AppColors.greenFlag.withAlpha(60))
                : (hasFlagged
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.error.withAlpha(60)),

            size: 30,
          ),
        ),
        Text(
          '$count',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ],
    );
  }
}
