import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/common_image_picker.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class PostImagePickerStep extends StatelessWidget {
  const PostImagePickerStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RateFlagText.fadedItalic(text: "Yüklemek için resim seçin"),
              SizedBox(height: 20),

              CommonImagePicker(
                selectedImage: state.selectedImage,
                onPickFromGallery: cubit.pickFromGallery,
                onPickFromCamera: cubit.pickFromCamera,
              ),

              SizedBox(height: 40),

              CustomElevatedButton.secondary(
                text: "Devam",
                onPressed: () {
                  if (state.selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Lütfen resim seçin")),
                    );
                    return;
                  }
                  cubit.goToPage(2);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
