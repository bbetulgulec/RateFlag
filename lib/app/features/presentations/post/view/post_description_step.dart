import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/features/presentations/post/cubit/post_cubit.dart';
import 'package:rate_flag/app/features/presentations/post/cubit/post_state.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/common/widget/buttons/custom_elevated_button.dart';
import 'package:rate_flag/app/common/widget/custom_text.dart';
import 'package:rate_flag/app/common/widget/text_fields/common_text_field.dart';


class PostDescriptionStep extends StatelessWidget {
  const PostDescriptionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state.isCreatePostSuccess) {
          Routes.clearAndPush(context, Routes.main);
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },

      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // 🔹 Ana içerik
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RateFlagText.head2(
                            text: TextConstants.postDescription,
                            context: context,
                          ),
                          SizedBox(height: 20.h),

                          CustomTextField(
                            initialValue: state.draftPost?.description ?? '',
                            label: TextConstants.whatIsYourSpecial,
                            keyboardType: TextInputType.text,
                            maxLength: 500,
                            maxLines: 6,
                            onChanged: cubit.setDescription,
                          ),

                          SizedBox(height: 40.h),

                          CustomElevatedButton.primary(
                            text: TextConstants.share,
                            onPressed: state.isCreatePostLoading
                                ? null
                                : () => cubit.createPost(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
