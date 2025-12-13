import 'package:flutter/material.dart';

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
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),

          // 👀 VIEW COUNT
          Positioned(bottom: 8, left: 8, child: _ViewCount(viewCount)),

          // 🔥 SELF POST
          if (isSelfPost)
            const Positioned(top: 8, left: 8, child: _SelfPostBadge()),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey.shade300,
      child: const Icon(Icons.image, size: 50, color: Colors.white),
    );
  }
}

class _ViewCount extends StatelessWidget {
  final String viewCount;
  const _ViewCount(this.viewCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.play_arrow, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            viewCount,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SelfPostBadge extends StatelessWidget {
  const _SelfPostBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "SELF POST 🔥",
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
