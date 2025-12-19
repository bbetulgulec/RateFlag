import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isSignOutLoading;
  final bool isSignOutSuccess;
  final String? errorMessage;

  const SettingsState({
    this.isSignOutLoading = false,
    this.isSignOutSuccess = false,
    this.errorMessage,
  });

  SettingsState copyWith({
    bool? isSignOutLoading,
    bool? isSignOutSuccess,
    String? errorMessage,
  }) {
    return SettingsState(
      isSignOutLoading: isSignOutLoading ?? this.isSignOutLoading,
      isSignOutSuccess: isSignOutSuccess ?? this.isSignOutSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isSignOutLoading, isSignOutSuccess, errorMessage];
}
