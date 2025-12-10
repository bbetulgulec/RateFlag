import 'package:flutter/material.dart';

class SettingAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const SettingAlertDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(content, style: const TextStyle(fontSize: 14)),
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
