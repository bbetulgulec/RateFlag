import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus loginStatus;
  final LoginStatus passwordResetStatus;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.loginStatus = LoginStatus.initial,
    this.passwordResetStatus = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? loginStatus,
    LoginStatus? passwordResetStatus,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
      passwordResetStatus: passwordResetStatus ?? this.passwordResetStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    loginStatus,
    passwordResetStatus,
    errorMessage,
  ];
}
