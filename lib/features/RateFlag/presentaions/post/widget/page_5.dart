import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagTextField.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

import '../../../domain/entity/post.dart';

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();
    final controller = TextEditingController(text: cubit.state.description);

    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        if (state.isCreatePostSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Post başarıyla kaydedildi!")));
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RateFlagText.head2(text: "Story Açıklaması"),

          SizedBox(height: 20),

          Rateflagtextfield(
            controller: controller,
            label: "Sizi eşsiz kılan şeyleri yazın...",
            keyboardType: TextInputType.text,
            maxLength: 500,
            maxLines: 6,
            onChanged: cubit.setDescription,
          ),

          const SizedBox(height: 70),

          Onboardingelevetedbutton.primary(
            text: "Paylaş",
            onPressed: () {
              final post = Post(
                postId: 'post_${DateTime.now().millisecondsSinceEpoch}',
                userId: FirebaseAuth.instance.currentUser?.uid ?? "",
                isPublic: cubit.state.isPublic ?? false,
                date: DateTime.now(),
                city: cubit.state.selectedCity ?? '',
                district: cubit.state.selectedDistrict ?? '',
                description: cubit.state.description ?? '',
                imageUrl: cubit.state.selectedImage?.path,
                latitude: cubit.state.latitude ?? 0.0,
                longitude: cubit.state.longitude ?? 0.0,
              );
              cubit.createPost(post, context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
