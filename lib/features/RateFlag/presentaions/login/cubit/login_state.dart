import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoginLoading;
  final bool isGoogleLoading;
  final bool isPasswordResetLoading;

  final bool isLoginSuccess;
  final bool isGoogleSuccess;
  final bool isPasswordResetSuccess;

  final String? errorMessage;

  const LoginState({
    this.isLoginLoading = false,
    this.isGoogleLoading = false,
    this.isPasswordResetLoading = false,
    this.isLoginSuccess = false,
    this.isGoogleSuccess = false,
    this.isPasswordResetSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoginLoading,
    bool? isGoogleLoading,
    bool? isPasswordResetLoading,
    bool? isLoginSuccess,
    bool? isGoogleSuccess,
    bool? isPasswordResetSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isPasswordResetLoading:
          isPasswordResetLoading ?? this.isPasswordResetLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isGoogleSuccess: isGoogleSuccess ?? this.isGoogleSuccess,
      isPasswordResetSuccess:
          isPasswordResetSuccess ?? this.isPasswordResetSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoginLoading,
    isGoogleLoading,
    isPasswordResetLoading,
    isLoginSuccess,
    isGoogleSuccess,
    isPasswordResetSuccess,
    errorMessage,
  ];
}
