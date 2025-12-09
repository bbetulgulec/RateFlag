import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPageIndex;
  final int totalPageCount;

  const OnboardingState({
    required this.currentPageIndex,
    required this.totalPageCount,
  });

  bool get isFirstPage => currentPageIndex == 0;
  bool get isLastPage => currentPageIndex == totalPageCount - 1;

  bool get showSkipButton => true;
  bool get showNextButton => !isLastPage;
  bool get showStartButton => isLastPage;

  OnboardingState copyWith({int? currentPageIndex, int? totalPageCount}) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      totalPageCount: totalPageCount ?? this.totalPageCount,
    );
  }

  @override
  List<Object?> get props => [currentPageIndex, totalPageCount];
}
