import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/assets_path.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/domain/model/post.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/view/post_info_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_grid_view.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_posts_empty.dart';

class ProfilePostContent extends StatelessWidget {
  final ProfileState state;

  const ProfilePostContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final List<Post> postsToShow = state.tabIndex == 0
        ? state.publicPosts
        : state.savedPost;

    if (postsToShow.isEmpty) {
      return ProfilePostsEmpty(
        mainText: state.tabIndex == 0
            ? TextConstants.noYetPost
            : TextConstants.noYetSavedPost,
        subText: state.tabIndex == 0
            ? TextConstants.willShowUpHere
            : TextConstants.saveAppearHere,
        icon: state.tabIndex == 0
            ? Icons.hourglass_empty
            : Icons.bookmark_border,
      );
    }

    return ProfileGridView(
      posts: postsToShow,
      lottieAsset: AssetsPath.imageLoading,
      onTap: (post) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) =>
                  getIt<PostInfoCubit>()..loadPostInfo(postId: post.postId),
              child: PostInfoScreen(postId: post.postId),
            ),
          ),
        );
      },
    );
  }
}
