import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_flag/app/common/constants/onboarding_constants.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/app/common/widget/custom_text.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_state.dart';
import 'package:rate_flag/app/common/widget/buttons/custom_elevated_button.dart';
import 'package:rate_flag/app/features/presentations/onboarding/widget/onboarding_bottom_controls.dart';

class OnboardingPageItem extends StatelessWidget {
  final Map<String, String> model;
  final int index;
  final VoidCallback? onSkip;
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final VoidCallback? onFinish;

  const OnboardingPageItem({
    super.key,
    required this.model,
    required this.index,
    this.onSkip,
    this.onBack,
    this.onNext,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (p, c) => p.currentPageIndex != c.currentPageIndex,
      builder: (context, state) {
        final isActive = state.currentPageIndex == index;
        final isLast = index == OnboardingConstants.pages.length - 1;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: !isLast && isActive
                      ? GestureDetector(
                          onTap: onSkip,
                          child: RateFlagText.fadedItalic(
                            text: TextConstants.skip,
                            context: context,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(model["image"]!, height: 300.h),
                      SizedBox(height: 30.h),
                      RateFlagText.head4(
                        text: model["text"]!,
                        context: context,
                      ),
                    ],
                  ),
                ),

                if (isActive)
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: OnboardingBottomControls(
                      index: index,
                      isLastPage: isLast,
                      onBack: onBack ?? () {},
                      onNext: onNext ?? () {},
                    ),
                  ),

                if (isActive && isLast)
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: CustomElevatedButton.primary(
                      text: TextConstants.letBegin,
                      onPressed: onFinish,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
