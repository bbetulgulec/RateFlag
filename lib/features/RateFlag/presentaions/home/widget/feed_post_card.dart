import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/self_post_badget.dart';

class FeedPostCard extends StatelessWidget {
  final String? imageUrl;
  final bool isSelfPost;
  final String viewCount;
  final bool isBig;

  const FeedPostCard({
    super.key,
    this.imageUrl,
    required this.isSelfPost,
    required this.viewCount,
    required this.isBig,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: isBig ? 3 / 4 : 1,
            child: imageUrl != null
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
            const Positioned(top: 8, left: 8, child: SelfPostBadget()),
        ],
      ),
    );
  }
}
