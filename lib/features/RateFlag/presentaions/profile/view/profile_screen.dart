import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/follow_list/view/follow_list_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_avatar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_buid_count.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_gesture_detector.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_icon_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_image_picker_sheet.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/widget/profile_post_content.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/view/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.h),
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

                  SizedBox(height: 20.h),

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

                  SizedBox(height: 25.h),

                  RateFlagText.head2(
                    text:
                        "${state.user?.firstName ?? ""} ${state.user?.lastName ?? ""}",
                    context: context,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileBuildCount(
                        label: TextConstants.post,
                        count: "${state.postCount}",
                      ),

                      ProfileBuildCount(
                        label: TextConstants.followers,
                        count: "${state.followersCount}",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FollowListScreen(
                                title: TextConstants.followers,
                                userIds: state.followers,
                              ),
                            ),
                          );
                        },
                      ),

                      ProfileBuildCount(
                        label: TextConstants.following,
                        count: "${state.followingCount}",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FollowListScreen(
                                title: TextConstants.following,
                                userIds: state.following,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 35.h),

                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
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
                        : ProfilePostContent(state: state),
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
