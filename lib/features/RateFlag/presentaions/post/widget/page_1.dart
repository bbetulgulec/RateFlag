// lib/features/RateFlag/presentaions/post/widget/page_1.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_card.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final postCubit = context.read<PostCubit>();

    return BlocBuilder<PostCubit, dynamic>(
      builder: (context, state) {
        final isPublic = state.isPublic ?? false;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Who do you want to post?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageCard(
                  icon: Icons.lock,
                  title: "Yalnızca Kendime",
                  isSelected: state.isPublic == false,
                  onTap: () => postCubit.setPublic(false),
                ),
                const SizedBox(width: 20),
                PageCard(
                  icon: Icons.public,
                  title: "Başka Birine",
                  isSelected: state.isPublic == true,
                  onTap: () => postCubit.setPublic(true),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                postCubit.nextPage();
              },
              child: const Text("Continue"),
            ),
          ],
        );
      },
    );
  }
}
