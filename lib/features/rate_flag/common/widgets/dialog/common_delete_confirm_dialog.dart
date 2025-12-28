import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const DeleteConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(TextConstants.no),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            TextConstants.yes,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}
