import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final bool isGreen;
  final int count;
  final bool hasFlagged; // kullanıcı oy verdi mi
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
                ? (hasFlagged ? Colors.green : Colors.green.shade400)
                : (hasFlagged ? Colors.red : Colors.red.shade400),
            size: 30,
          ),
        ),
        Text(
          '$count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
