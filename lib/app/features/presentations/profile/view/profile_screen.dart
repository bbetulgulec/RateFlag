import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/common/widget/custom_text.dart';
import 'package:rate_flag/app/features/data/model/post.dart';
import 'package:rate_flag/app/features/presentations/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/app/features/presentations/profile/cubit/profile_state.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_avatar.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_buid_count.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_gesture_detector.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_icon_widget.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_image_picker_sheet.dart';
import 'package:rate_flag/app/features/presentations/profile/widget/profile_post_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
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
                        Routes.push(context, Routes.setting);
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
                          child: ProfileImagePickerSheet(
                            onPressedCamera: () {
                              Routes.pop(context);
                              cubit.pickFromCamera();
                            },
                            onPressedGallery: () {
                              Routes.pop(context);
                              cubit.pickFromGallery();
                            },
                          ),
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
                          Routes.push(
                            context,
                            Routes.followList,
                            arguments: {
                              'title': TextConstants.followers,
                              'userIds': state.followers,
                            },
                          );
                        },
                      ),

                      ProfileBuildCount(
                        label: TextConstants.following,
                        count: "${state.followingCount}",
                        onTap: () {
                          Routes.push(
                            context,
                            Routes.followList,
                            arguments: {
                              'title': TextConstants.following,
                              'userIds': state.following,
                            },
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
                        : ProfilePostContent(
                            state: state,
                            onTap: (Post p1) {
                              Routes.push(context, Routes.postInfo);
                            },
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
