import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/view/post_info_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_avatar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_buid_count.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_gesture_detector.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_grid_view.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_icon_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_image_picker_sheet.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_posts_empty.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/view/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ProfileIconWidget.small(
                      icon: Icons.settings_outlined,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => getIt<SettingsCubit>(),
                              child: SettingsScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  ProfileAvatar(
                    radius: 45,
                    imageUrl: state.user?.photoUrl,
                    selectedImage: state.selectedImage,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: const ProfileImagePickerSheet(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  RateFlagText.head2(
                    text:
                        "${state.user?.firstName ?? ""} ${state.user?.lastName ?? ""}",
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileBuildCount(
                        label: "Posts",
                        count: "${state.postCount}",
                      ),
                      ProfileBuildCount(
                        label: "Followers",
                        count: "${state.followersCount}",
                      ),
                      ProfileBuildCount(
                        label: "Following",
                        count: "${state.followingCount}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileGestureDetector(
                          icon: Icons.grid_on,
                          tabIndex: state.tabIndex,
                          index: 0,
                          onTap: () {
                            context.read<ProfileCubit>().changeTab(0);
                          },
                        ),
                        ProfileGestureDetector(
                          icon: Icons.bookmark_border,
                          tabIndex: state.tabIndex,
                          index: 1,
                          onTap: () {
                            context.read<ProfileCubit>().changeTab(1);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: state.isPostLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildPostContent(context, state),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildPostContent(BuildContext context, ProfileState state) {
  List<Post> postsToShow = state.tabIndex == 0
      ? state.publicPosts
      : state.savedPost;

  if (postsToShow.isEmpty) {
    return ProfilePostsEmpty(
      mainText: state.tabIndex == 0 ? "No posts yet 👎" : "No saved posts ⭐",
      subText: state.tabIndex == 0
          ? "They will show up here"
          : "Posts you save will appear here",
      icon: state.tabIndex == 0 ? Icons.hourglass_empty : Icons.bookmark_border,
    );
  }

  return ProfileGridView(
    posts: postsToShow,
    lottieAsset: 'assets/lottie/image_loading.json',
    onTap: (post) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PostInfoCubit>(),
            child: PostInfoScreen(postId: post.postId),
          ),
        ),
      );
    },
  );
}
