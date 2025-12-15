import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class ProfileGridView extends StatelessWidget {
  final List<Post> posts;
  final String lottieAsset; // Lottie json dosyası için path

  const ProfileGridView({
    super.key,
    required this.posts,
    required this.lottieAsset,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            post.imageUrl ?? "",
            fit: BoxFit.cover,
            // Loading sırasında Lottie göster
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Yüklendi
              return Center(
                child: Lottie.asset(
                  lottieAsset,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              );
            },
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
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
