import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Resim seçin',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // IMAGE PREVIEW
            state.selectedImage == null
                ? Container(
                    width: 180,
                    height: 180,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 60),
                  )
                : Image.file(
                    state.selectedImage!,
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                context.read<PostCubit>().checkGalleryPermission();
                context.read<PostCubit>().pickImage();
              },
              child: Text("Fotoğraf Seç"),
            ),

            Spacer(),

            ElevatedButton(
              onPressed: () {
                if (state.selectedImage == null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Lütfen resim seçin")));
                  return;
                }

                context.read<PostCubit>().goToPage(2);
              },
              child: Text("Devam"),
            ),
          ],
        );
      },
    );
  }
}
