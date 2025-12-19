import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_flag/features/RateFlag/common/constants/onboarding_constants.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/texts/custom_text.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_state.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/custom_elevated_button.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/widget/onboarding_bottom_controls.dart';

class OnboardingPageItem extends StatelessWidget {
  final Map<String, String> model;
  final int index;

  const OnboardingPageItem({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (prev, curr) => prev.currentPageIndex != curr.currentPageIndex,
      builder: (context, state) {
        final bool isActivePage = state.currentPageIndex == index;
        final bool isLastPage = index == OnboardingConstants.pages.length - 1;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                // 🔹 ÜST (SKIP)
                Align(
                  alignment: Alignment.topRight,
                  child: !isLastPage && isActivePage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => getIt<LoginCubit>(),
                                  child: LoginScreen(),
                                ),
                              ),
                            );
                          },
                          child: RateFlagText.fadedItalic(text: "Skip"),
                        )
                      : const SizedBox.shrink(),
                ),

                // 🔹 ORTA ALAN
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        model["image"]!,
                        height: 350.h, // 🔥 ekrana göre
                      ),
                      SizedBox(height: 24.h),
                      RateFlagText.fadedItalic(text: model["text"]!),
                    ],
                  ),
                ),

                // 🔹 ALT KONTROLLER
                if (isActivePage)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: OnboardingBottomControls(
                      index: index,
                      isLastPage: isLastPage,
                    ),
                  ),

                if (isActivePage && isLastPage)
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: CustomElevatedButton.primary(
                      text: "Hadi Başlayalım",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => getIt<LoginCubit>(),
                              child: LoginScreen(),
                            ),
                          ),
                        );
                      },
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
