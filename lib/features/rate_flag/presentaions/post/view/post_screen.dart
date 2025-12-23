import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_visibility_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_image_picker_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_city_selection_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_district_selection_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_description_step.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/common_icon_button.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final pages = [
      PostVisibilityStep(),
      PostImagePickerStep(),
      PostCitySelectionStep(),
      PostDistrictSelectionStep(),
      PostDescriptionStep(),
    ];

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // 🔹 NORMAL UI
              Column(
                children: [
                  SizedBox(height: 50.h),

                  Row(
                    children: [
                      CommonIconButton(
                        icon: Icons.arrow_back,
                        isVisible: state.currentPage > 0,
                        onPressed: () {
                          context.read<PostCubit>().previousPage();
                        },
                      ),
                      const Spacer(),
                      CommonIconButton(
                        icon: Icons.close,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),

                  Expanded(
                    child: BlocListener<PostCubit, PostState>(
                      listener: (context, state) {
                        _controller.animateToPage(
                          state.currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: PageView.builder(
                        controller: _controller,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pages.length,
                        onPageChanged: (i) =>
                            context.read<PostCubit>().goToPage(i),
                        itemBuilder: (_, i) => Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: pages[i],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 🔥 FULLSCREEN LOADING (HER ŞEYİ KARARTIR)
              if (state.isCreatePostLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.black.withAlpha(45),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
