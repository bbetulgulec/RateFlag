import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/toast_message.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/functions/calculateAge.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_image_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_material_button.dart';

class PostInfoScreen extends StatelessWidget {
  final String postId;
  final String userId;

  const PostInfoScreen({super.key, required this.postId, required this.userId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostInfoCubit>()
      ..loadPostInfo(userId: userId, postId: postId);

    final calculateAge = Calculateage();

    return BlocConsumer<PostInfoCubit, PostInfoState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.show(context, message: state.errorMessage!);
        }
        if (state.followMessage != null) {
          ToastMessage.show(context, message: state.followMessage!);
        }
      },
      builder: (context, state) {
        if (state.isLoadPostInfoLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final post = state.post;
        final user = state.user;

        if (post == null || user == null) {
          return const Scaffold(body: Center(child: Text("Veri bulunamadı")));
        }

        final age = calculateAge.calculateAge(user['birthDate']);

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextButton(
                  onPressed: () {
                    cubit.toggleFollow(userId);
                  },
                  child: state.isFollowActionLoading
                      ? const SizedBox(
                          width: 80,
                          height: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Text(
                          state.isFollowing == true
                              ? "Takibi Bırak"
                              : "Takip Et",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  cubit.sharePost();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostImageWidget(imageUrl: post.imageUrl, height: 500),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RateFlagText.head2(
                          text: "${user['firstName']} ${user['lastName']}",
                        ),
                        const SizedBox(width: 10),
                        RateFlagText.fadedItalic(text: "$age"),
                      ],
                    ),
                    Row(
                      children: [
                        FlagButton(
                          isGreen: true,
                          count: state.greenFlagCount ?? 0,
                          hasFlagged:
                              (state.hasGreenFlag ?? false) ||
                              (state.hasRedFlag ?? false),

                          onPressedCallback: () => cubit.ratePost(
                            postOwnerId: post.userId,
                            postId: post.postId,
                            isGreen: true,
                          ),
                        ),
                        FlagButton(
                          isGreen: false,
                          count: state.redFlagCount ?? 0,
                          hasFlagged:
                              (state.hasGreenFlag ?? false) ||
                              (state.hasRedFlag ?? false),

                          onPressedCallback: () => cubit.ratePost(
                            postOwnerId: post.userId,
                            postId: post.postId,
                            isGreen: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RateFlagText.fadedItalic(
                  text: "📍 ${post.city} / ${post.district}",
                ),
                const SizedBox(height: 8),
                Text(post.description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
