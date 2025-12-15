import 'package:flutter/material.dart';

class ProfilePostsEmpty extends StatelessWidget {
  final String mainText;
  final String subText;
  final IconData icon;

  const ProfilePostsEmpty({
    super.key,
    required this.mainText,
    required this.subText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 45, color: Colors.grey),
        const SizedBox(height: 10),
        Text(
          mainText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(subText, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
