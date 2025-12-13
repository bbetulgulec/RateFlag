import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class ProfileGridView extends StatelessWidget {
  final List<Post> posts;

  const ProfileGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Image.network(
          post.imageUrl ?? "",
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.error),
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
