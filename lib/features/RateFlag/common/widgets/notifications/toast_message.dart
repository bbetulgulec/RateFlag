import 'package:flutter/material.dart';

class ToastMessage extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const ToastMessage({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // Görünüm mantığını buraya taşıdık
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black38,
    Color textColor = Colors.white,
  }) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: AnimationController(
                vsync: Navigator.of(context),
                duration: const Duration(milliseconds: 300),
              )..forward(),
              curve: Curves.easeOut,
            ),
          ),
          child: ToastMessage(
            message: message,
            backgroundColor: backgroundColor,
            textColor: textColor,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Süre sonunda kaldır
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
