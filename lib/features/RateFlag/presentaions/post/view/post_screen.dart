import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/cubit/main_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/view/main_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_visibility_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_image_picker_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_city_selection_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_district_selection_step.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_description_step.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  bool? isPublic;
  File? selectedImage;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    final pages = [
      PostVisibilityStep(),
      PostImagePickerStep(),
      PostCitySelectionStep(),
      PostDistrictSelectionStep(),
      PostDescriptionStep(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => getIt<MainCubit>()),
                      BlocProvider(create: (_) => getIt<HomeCubit>()),
                    ],
                    child: MainScreen(),
                  ),
                ),
              );
            },
            child: Align(
              alignment: AlignmentGeometry.centerRight,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            ),
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
                itemCount: pages.length,
                onPageChanged: (i) => context.read<PostCubit>().goToPage(i),
                physics: const NeverScrollableScrollPhysics(),

                itemBuilder: (_, i) =>
                    Padding(padding: const EdgeInsets.all(16), child: pages[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
