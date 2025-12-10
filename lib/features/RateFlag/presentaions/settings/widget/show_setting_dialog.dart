import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/setting_alert_dialog.dart';

void showSettingDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (_) => SettingAlertDialog(title: title, content: content),
  );
}

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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hayır"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm(); // Silme işlemini cubit'e gönderiyoruz
          },
          child: const Text("Evet", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
