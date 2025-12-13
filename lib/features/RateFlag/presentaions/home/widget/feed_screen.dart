import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/feed_post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isAllPostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          if (state.posts.isEmpty) {
            return const Center(child: Text("Henüz post yok"));
          }

          return Align(
            alignment: AlignmentGeometry.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];

                  // 🔥 STAGGERED HİSSİ
                  final isBig = index % 4 == 0 || index % 5 == 0;

                  // 🔥 SELF POST
                  final isSelfPost =
                      post.userId == context.read<HomeCubit>().currentUserId;

                  return FeedPostCard(
                    imageUrl: post.imageUrl,
                    isSelfPost: isSelfPost,
                    isBig: isBig,
                    viewCount: "9.9K",
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
