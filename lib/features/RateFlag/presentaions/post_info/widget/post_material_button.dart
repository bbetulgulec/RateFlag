import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final bool isGreen;
  final int count;
  final void Function({required String currentUserId, required bool isGreen})
  onPressedCallback;

  const FlagButton({
    super.key,
    required this.isGreen,
    required this.count,
    required this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        final currentUserId = FirebaseAuth.instance.currentUser!.uid;
        onPressedCallback(currentUserId: currentUserId, isGreen: isGreen);
      },
      child: Row(
        children: [
          Icon(
            Icons.flag,
            color: isGreen ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(count.toString()),
        ],
      ),
    );
  }
}
