import 'package:flutter/material.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class SettingAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  const SettingAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(content, style: TextStyle(fontSize: 14.sp)),
      ),
      actions: [
        TextButton(
          child: const Text(TextConstants.close),
          onPressed: onPressed,

          //Navigator.pop(context),
        ),
      ],
    );
  }
}
