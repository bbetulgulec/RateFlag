import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_avatar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_buid_count.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_gesture_detector.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_grid_view.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_icon_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_posts_empty.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/view/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().loadPosts();
    final profileCubit = context.read<ProfileCubit>();
    profileCubit.loadUserFollowData(FirebaseAuth.instance.currentUser!.uid);
    profileCubit.loadUser(FirebaseAuth.instance.currentUser!.uid);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final tabIndex = state.tabIndex;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileIconWidget.small(
                        icon: Icons.chat_bubble_outline,
                        onPressed: () {},
                      ),
                      ProfileIconWidget.small(
                        icon: Icons.settings_outlined,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// ------- PROFİL FOTOĞRAF + KAMERA --------
                  ProfileAvatar(radius: 45),

                  const SizedBox(height: 25),

                  RateFlagText.head2(
                    text:
                        "${state.user?.firstName ?? "tttt"} ${state.user?.lastName ?? "gggg"}",
                  ),

                  /// ------- POSTS – FOLLOWERS – FOLLOWING --------
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
                        label: "Followering",
                        count: "${state.followingCount}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

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
                          onTap: () =>
                              context.read<ProfileCubit>().changeTab(0),
                        ),
                        ProfileGestureDetector(
                          icon: Icons.bookmark_border,
                          tabIndex: state.tabIndex,
                          index: 1,
                          onTap: () =>
                              context.read<ProfileCubit>().changeTab(1),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  Expanded(
                    child: state.isPostLoading
                        ? Center(child: CircularProgressIndicator())
                        : state.posts.isEmpty
                        ? ProfilePostsEmpty(
                            mainText: "No posts yet 👎",
                            subText: "They will show up here",
                            icon: Icons.hourglass_empty,
                          )
                        : ProfileGridView(
                            posts: state.posts,
                            lottieAsset: 'assets/lottie/image_loading.json',
                          ),
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
