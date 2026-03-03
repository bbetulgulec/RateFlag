import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/features/presentations/post/cubit/post_cubit.dart';
import 'package:rate_flag/app/features/presentations/post/cubit/post_state.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/app/common/widget/buttons/common_image_picker.dart';
import 'package:rate_flag/app/common/widget/buttons/custom_elevated_button.dart';
import 'package:rate_flag/app/common/widget/custom_text.dart';


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
              RateFlagText.fadedItalic(
                text: TextConstants.chooseUploadImage,
                context: context,
              ),
              SizedBox(height: 20.h),

              CommonImagePicker(
                selectedImage: state.selectedImage,
                onPickFromGallery: cubit.pickFromGallery,
                onPickFromCamera: cubit.pickFromCamera,
              ),

              SizedBox(height: 40.h),

              CustomElevatedButton.secondary(
                text: TextConstants.move,
                onPressed: () {
                  if (state.selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(TextConstants.chooseUploadImage)),
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
