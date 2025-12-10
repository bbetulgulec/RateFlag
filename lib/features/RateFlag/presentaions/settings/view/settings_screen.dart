import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/view/account_info_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/setting_card.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/widget/show_setting_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: AlignmentGeometry.topLeft,
          child: Rateflagtext.Maintitle(text: "Ayarlar"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Rateflagtext.Maintitle(text: "Destek"),
            ),
            const SizedBox(height: 15),
            SettingCard(
              icon: Icons.description_outlined,
              title: "Terms of Service",
              onTap: () {
                showSettingDialog(
                  context,
                  "Terms of Service",
                  "1. This app is provided “as is” without warranties.\n2. Users are responsible for content shared in the app.\n3. Premium purchases are non-refundable unless required by law.\n4. Misuse may result in account suspension.\n5. Using the app means you accept the latest Terms.",
                );
              },
            ),

            SettingCard(
              icon: Icons.lock_outline,
              title: "Privacy Policy",
              onTap: () {
                showSettingDialog(context, "Privacy Policy", """
• We collect basic analytics to improve the app.
• Personal information is stored securely.
• We do not sell your data to third parties.
• You may request data deletion at any time.
""");
              },
            ),

            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Rateflagtext.Maintitle(text: "Hesap"),
            ),

            SettingCard(
              icon: Icons.settings_accessibility,
              title: "Hesap Bilgileri güncelle",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountInfoScreen()),
                );
              },
            ),
            SettingCard(
              icon: Icons.delete_forever,
              title: "Hesap Sil",
              onTap: () {},
            ),

            SettingCard(
              icon: Icons.exit_to_app,
              title: "Çıkıs yap",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
