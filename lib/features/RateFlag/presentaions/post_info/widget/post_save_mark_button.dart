import 'package:flutter/material.dart';

class SaveBookmarkButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onPressed;

  const SaveBookmarkButton({
    super.key,
    required this.isSaved,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          key: ValueKey(isSaved),
          size: 28,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
