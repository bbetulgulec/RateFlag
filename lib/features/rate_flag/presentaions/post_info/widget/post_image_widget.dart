import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';

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
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              child: Center(child: Icon(Icons.image, size: 50.sp)),
            ),
    );
  }
}
