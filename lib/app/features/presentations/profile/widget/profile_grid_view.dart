import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/app/features/data/model/post.dart';

class ProfileGridView extends StatelessWidget {
  final List<Post> posts;
  final String lottieAsset;
  final void Function(Post post)? onTap;

  const ProfileGridView({
    super.key,
    required this.posts,
    required this.lottieAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: InkWell(
            onTap: () => onTap?.call(post),
            child: Image.network(
              post.imageUrl ?? "",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Lottie.asset(
                    lottieAsset,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                );
              },
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
    );
  }
}
