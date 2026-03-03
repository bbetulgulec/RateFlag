import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/features/presentations/onboarding/cubit/onboarding_state.dart';
import 'package:flutter/material.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController;

  OnboardingCubit({required int totalPageCount})
    : pageController = PageController(),
      super(
        OnboardingState(
          currentPageIndex: 0,
          totalPageCount: totalPageCount,
          completed: false,
        ),
      );

  void pageChanged(int index) {
    emit(state.copyWith(currentPageIndex: index));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    if (!state.isLastPage) {
      pageChanged(state.currentPageIndex + 1);
    } else {
      finish();
    }
  }

  void finish() {
    emit(state.copyWith(completed: true));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
