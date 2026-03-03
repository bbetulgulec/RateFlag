import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPageIndex;
  final int totalPageCount;
  final bool completed;

  const OnboardingState({
    required this.currentPageIndex,
    required this.totalPageCount,
    required this.completed,
  });

  bool get isFirstPage => currentPageIndex == 0;
  bool get isLastPage => currentPageIndex == totalPageCount - 1;

  bool get showSkipButton => true;
  bool get showNextButton => !isLastPage;
  bool get showStartButton => isLastPage;

  OnboardingState copyWith({
    int? currentPageIndex,
    int? totalPageCount,
    bool? completed,
  }) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      totalPageCount: totalPageCount ?? this.totalPageCount,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [currentPageIndex, totalPageCount, completed];
}
