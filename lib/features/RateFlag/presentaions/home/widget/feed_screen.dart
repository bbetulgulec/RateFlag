import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rate_flag/features/RateFlag/data/repositories/firebase_firestore_%C4%B1mpl.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/feed_post_card.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/view/post_info_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
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

                final isBig = index % 4 == 0 || index % 5 == 0;

                final isSelfPost =
                    post.userId == context.read<HomeCubit>().currentUserId;

                return FeedPostCard(
                  imageUrl: post.imageUrl,
                  isSelfPost: isSelfPost,
                  isBig: isBig,
                  viewCount: "9.9K",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) {
                            final cubit = PostInfoCubit(
                              LoadPostUserUsecase(FirebaseFirestoreImpl()),
                            );

                            return cubit;
                          },
                          child: PostInfoScreen(
                            postId: post.postId,
                            userId: post.userId,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
