import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required int totalPageCount})
    : super(
        OnboardingState(currentPageIndex: 0, totalPageCount: totalPageCount),
      );

  void pageChanged(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }

  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
    }
  }
}
