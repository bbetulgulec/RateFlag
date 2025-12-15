import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_flag/features/RateFlag/common/constants/OnboardingList.dart';
import 'package:rate_flag/features/RateFlag/common/widget/rateFlagText.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/view/login_screen.dart';
import 'package:rate_flag/features/RateFlag/common/widget/elevatedButtonWidget.dart';

class OnboardingPageView extends StatefulWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemCount: OnboardingList.pages.length,
      onPageChanged: (i) {
        setState(() => currentIndex = i);
        widget.onPageChanged(i);
      },
      itemBuilder: (context, i) {
        return _buildPage(OnboardingList.pages[i], i);
      },
    );
  }

  Widget _buildPage(Map<String, String> model, int index) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // IMAGE
            Center(
              child: SvgPicture.asset(
                model["image"]!,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),

            const SizedBox(height: 50),

            // TEXT
            RateFlagText.fadedItalic(text: model["text"]!),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnboardingList.pages.length,
                (dotIndex) => _buildIndicator(dotIndex),
              ),
            ),

            const SizedBox(height: 40),

            if (index == OnboardingList.pages.length - 1)
              Center(
                child: Onboardingelevetedbutton.primary(
                  text: "Hadi Başlayalım",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = index == currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.deepPurple : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
