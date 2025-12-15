import 'package:flutter/material.dart';

class ShowDeleteDialog {
  void showDeleteDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hayır"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text("Evet", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
