import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/onboarding/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required int totalPageCount})
    : super(
        OnboardingState(currentPageIndex: 0, totalPageCount: totalPageCount),
      );

  //PageView içinde sayfa değiştiğinde çağırılır
  void pageChanged(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }

  //Sonraki sayfaya geç
  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
    }
  }

  // total atlama
  void skip() {
    emit(state.copyWith(currentPageIndex: state.totalPageCount - 1));
  }
}
