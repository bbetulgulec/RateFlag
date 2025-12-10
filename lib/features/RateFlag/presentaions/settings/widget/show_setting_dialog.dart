import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/setting_alert_dialog.dart';

void showSettingDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (_) => SettingAlertDialog(title: title, content: content),
  );
}
