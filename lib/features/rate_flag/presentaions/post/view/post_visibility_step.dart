import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/widget/page_card.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/cubit/post_cubit.dart';

class PostVisibilityStep extends StatelessWidget {
  const PostVisibilityStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            RateFlagText.head2(
              text: TextConstants.howWantToShare,
              context: context,
            ),

            SizedBox(height: 40.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageCard(
                    icon: Icons.person,
                    title: TextConstants.postMyself,
                    isSelected: state.draftPost?.isPublic == false,
                    onTap: () => context.read<PostCubit>().setPublic(false),
                  ),
                ),
                SizedBox(width: 20.h),
                Expanded(
                  child: PageCard(
                    icon: Icons.public,
                    title: TextConstants.postSomeoneElse,
                    isSelected: state.draftPost?.isPublic == true,
                    onTap: () => context.read<PostCubit>().setPublic(true),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),

            CustomElevatedButton.primary(
              text: TextConstants.move,
              onPressed: state.draftPost?.isPublic == null
                  ? null
                  : () {
                      context.read<PostCubit>().nextPage();
                    },
            ),
          ],
        );
      },
    );
  }
}
