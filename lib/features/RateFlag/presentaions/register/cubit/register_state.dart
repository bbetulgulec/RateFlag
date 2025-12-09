import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool isRegisterLoading;
  final bool isRegisterSuccess;
  final bool isEmailVerified;
  final String? errorMessage;

  final DateTime? birthDate;

  const RegisterState({
    this.isRegisterLoading = false,
    this.isRegisterSuccess = false,
    this.isEmailVerified = false,
    this.errorMessage,
    this.birthDate,
  });

  RegisterState copyWith({
    bool? isRegisterLoading,
    bool? isRegisterSuccess,
    bool? isEmailVerified,
    String? errorMessage,
    DateTime? birthDate,
  }) {
    return RegisterState(
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      errorMessage: errorMessage ?? this.errorMessage,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props => [
    isRegisterLoading,
    isRegisterSuccess,
    isEmailVerified,
    errorMessage,
    birthDate,
  ];
}
