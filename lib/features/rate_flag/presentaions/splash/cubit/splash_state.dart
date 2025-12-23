class SplashState {
  final bool isLoading;
  final bool isFinished;
  final bool isAuthenticated;

  const SplashState({
    this.isLoading = true,
    this.isFinished = false,
    this.isAuthenticated = false,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? isFinished,
    bool? isAuthenticated,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isFinished: isFinished ?? this.isFinished,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
