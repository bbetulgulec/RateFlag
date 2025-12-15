import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final LoginStatus googleLoginStatus;
  final LoginStatus passwordResetStatus;

  final String? errorMessage;

  const LoginState({
    this.loginStatus = LoginStatus.initial,
    this.googleLoginStatus = LoginStatus.initial,
    this.passwordResetStatus = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? loginStatus,
    LoginStatus? googleLoginStatus,
    LoginStatus? passwordResetStatus,
    String? errorMessage,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      googleLoginStatus: googleLoginStatus ?? this.googleLoginStatus,
      passwordResetStatus: passwordResetStatus ?? this.passwordResetStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    googleLoginStatus,
    passwordResetStatus,
    errorMessage,
  ];
}
