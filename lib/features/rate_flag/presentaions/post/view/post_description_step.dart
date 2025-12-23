import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/text_fields/common_text_field.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/cubit/main_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class PostDescriptionStep extends StatelessWidget {
  const PostDescriptionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state.isCreatePostSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => getIt<MainCubit>(),
                child: const MainScreen(),
              ),
            ),
            (route) => false, // 🔥 STACK TEMİZ
          );
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
