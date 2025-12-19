import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_card.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';

class PostVisibilityStep extends StatelessWidget {
  const PostVisibilityStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        final postCubit = context.read<PostCubit>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            RateFlagText.head2(text: "Kiminle paylaşmak istersiniz?"),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageCard(
                    icon: Icons.lock,
                    title: "Yalnızca Kendime",
                    isSelected: state.isPublic == false,
                    onTap: () => postCubit.setPublic(false),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PageCard(
                    icon: Icons.public,
                    title: "Başka Birine",
                    isSelected: state.isPublic == true,
                    onTap: () => postCubit.setPublic(true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            CustomElevatedButton.primary(
              text: "Devam",
              onPressed: () {
                postCubit.nextPage();
              },
            ),
          ],
        );
      },
    );
  }
}
