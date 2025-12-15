import 'package:flutter/material.dart';

class PostImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double height;

  const PostImageWidget({super.key, required this.imageUrl, this.height = 400});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
              ),
            )
          : Container(
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.image, size: 50)),
            ),
    );
  }
}
