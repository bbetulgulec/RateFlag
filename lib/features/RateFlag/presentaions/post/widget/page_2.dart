import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
              Rateflagtext.fadedItalic(text: "Yüklemek için resim seçin"),
              SizedBox(height: 20),

              InkWell(
                onTap: () {
                  cubit.checkGalleryPermission();
                  cubit.pickImage();
                },
                child: state.selectedImage == null
                    ? Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          state.selectedImage!,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),

              SizedBox(height: 40),

              Onboardingelevetedbutton.secondary(
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
