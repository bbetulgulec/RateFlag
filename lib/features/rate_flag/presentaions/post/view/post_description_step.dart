import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/rate_flag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/post/cubit/post_state.dart';

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
