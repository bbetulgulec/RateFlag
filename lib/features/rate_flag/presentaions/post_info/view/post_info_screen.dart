import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/common_icon_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/commun_text_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/domain/model/post.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';
import 'package:rate_flag/features/RateFlag/common/utils/functions/calculate_age.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_comments_section.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_image_widget.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_info_details_text.dart';

class PostInfoScreen extends StatefulWidget {
  final String postId;
  final Post? post;

  const PostInfoScreen({super.key, required this.postId, this.post});

  @override
  State<PostInfoScreen> createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends State<PostInfoScreen> {
  late final PostInfoCubit cubit;
  final calculateAge = Calculateage();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = context.read<PostInfoCubit>();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return BlocConsumer<PostInfoCubit, PostInfoState>(
      listener: (context, state) {},

      builder: (context, state) {
        // Loading
        if (state.postInfoStatus == RequestStatus.loading ||
            state.postInfoStatus == RequestStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //  Error
        if (state.postInfoStatus == RequestStatus.failure) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage ?? TextConstants.didNotData),
            ),
          );
        }

        final post = state.post;
        final user = state.user;

        if (post == null || user == null) {
          return const Scaffold(body: Center(child: Text(TextConstants.error)));
        }

        final age = calculateAge.calculateAge(user.birthDate);

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CommonIconButton(
              icon: Icons.arrow_back,
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              if (currentUserId != null && post.userId != currentUserId)
                CommunTextButton(
                  text: state.isFollowing
                      ? TextConstants.followOut
                      : TextConstants.follow,
                  isLoading: state.followStatus == RequestStatus.loading,
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () => cubit.handleToggleFollow(post.userId),
                ),
              CommonIconButton(
                icon: Icons.share,
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: cubit.sharePost,
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostImageWidget(imageUrl: post.imageUrl, height: 400.h),

                SizedBox(height: 16.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: PostInfoDetailsTextWithFlags(
                    fullName: "${user.firstName} ${user.lastName}",
                    age: age,
                    city: post.city,
                    district: post.district,
                    description: post.description,
                    greenFlagCount: state.greenFlagCount ?? 0,
                    redFlagCount: state.redFlagCount ?? 0,
                    hasGreenFlag: state.hasGreenFlag ?? false,
                    hasRedFlag: state.hasRedFlag ?? false,
                    isSaved: state.isSaved,
                    onGreenFlag: () =>
                        cubit.ratePost(post: post, isGreen: true),
                    onRedFlag: () => cubit.ratePost(post: post, isGreen: false),
                    onSaveToggle: () => cubit.toggleSavePost(post),
                  ),
                ),

                PostCommentsSection(
                  status: state.commentStatus,
                  comments: state.comments ?? [],
                  commentUsers: state.commentUsers ?? {},
                ),

                SizedBox(height: 16.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _commentController,
                          label: 'Yorum yaz...',
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CommonIconButton(
                        icon: Icons.send,
                        onPressed: () {
                          cubit.submitComment(
                            widget.postId,
                            _commentController.text,
                          );

                          _commentController.clear();
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
