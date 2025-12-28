import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/core/enum/request_status.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/widget/feed_post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.loadPostsStatus == RequestStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        if (state.posts.isEmpty) {
          return const Center(child: Text(TextConstants.dontHaveAnyYetPost));
        }

        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().loadAllPosts();
              },
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  final isBig = index % 4 == 0 || index % 5 == 0;

                  return FeedPostCard(
                    imageUrl: post.imageUrl,
                    isSelfPost: post.userId == currentUserId,
                    isBig: isBig,
                    onPressed: () {
                      Routes.push(context, Routes.postInfo, arguments: post);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
