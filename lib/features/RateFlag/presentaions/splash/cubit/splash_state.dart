class SplashState {
  final bool isLoading;
  final bool isFinished;

  const SplashState({this.isLoading = true, this.isFinished = false});

  SplashState copyWith({bool? isLoading, bool? isFinished}) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
