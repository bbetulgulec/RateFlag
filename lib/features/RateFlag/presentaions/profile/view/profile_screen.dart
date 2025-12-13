import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_buid_count.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_grid_view.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_icon_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/view/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().loadPosts();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final tabIndex = state.tabIndex;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  /// ------- ÜST İKONLAR --------
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 6,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 16,
                          child: Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// ------- POSTS – FOLLOWERS – FOLLOWING --------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ProfileBuildCount(label: "Posts", count: "0"),
                      ProfileBuildCount(label: "Followers", count: "0"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// ------- TAB BAR (Grid - Saved) --------
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
                        GestureDetector(
                          onTap: () =>
                              context.read<ProfileCubit>().changeTab(0),
                          child: Icon(
                            Icons.grid_on,
                            size: 28,
                            color: tabIndex == 0 ? Colors.black : Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.read<ProfileCubit>().changeTab(1),
                          child: Icon(
                            Icons.bookmark_border,
                            size: 28,
                            color: tabIndex == 1 ? Colors.black : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  Expanded(
                    child: state.isPostLoading
                        ? Center(child: CircularProgressIndicator())
                        : state.posts.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 45,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "No posts yet 👎",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "They will show up here",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : ProfileGridView(posts: state.posts),
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
