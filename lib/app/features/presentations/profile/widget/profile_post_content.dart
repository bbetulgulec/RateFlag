import 'package:flutter/material.dart';
import 'package:rate_flag/app/common/constants/assets_path.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/app/features/data/model/post.dart';
import 'package:rate_flag/app/features/presentations/profile/cubit/profile_state.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_grid_view.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_posts_empty.dart';

class ProfilePostContent extends StatelessWidget {
  final ProfileState state;
  final void Function(Post)? onTap;

  const ProfilePostContent({
    super.key,
    required this.state,
    required this.onTap,
  });

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
      onTap: onTap,
    );
  }
}
