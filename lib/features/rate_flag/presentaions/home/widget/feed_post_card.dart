import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/widget/self_post_badget.dart';

class FeedPostCard extends StatelessWidget {
  final String? imageUrl;
  final bool isSelfPost;
  final bool isBig;
  final VoidCallback? onPressed;

  const FeedPostCard({
    super.key,
    this.imageUrl,
    required this.isSelfPost,
    required this.isBig,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: isBig ? 3 / 4 : 1,
              child: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      memCacheHeight: 800,
                      memCacheWidth: 800,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : CircularProgressIndicator(),
            ),

            if (isSelfPost)
              Positioned(top: 8.h, left: 8.h, child: SelfPostBadget()),
          ],
        ),
      ),
    );
  }
}
