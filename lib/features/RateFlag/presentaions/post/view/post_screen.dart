import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/cubit/post_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/build_indicator.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_1.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_2.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_3.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_4.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/widget/page_5.dart';

class PostPageView extends StatefulWidget {
  const PostPageView({super.key});

  @override
  State<PostPageView> createState() => _PostPageViewState();
}

class _PostPageViewState extends State<PostPageView> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  bool? isPublic;
  File? selectedImage;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    final pages = [Page1(), Page2(), Page3(), Page4(), Page5()];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (i) => BuildIndicator(currentIndex: currentIndex, index: i),
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
                physics: currentIndex == 0 && selectedImage == null
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
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
