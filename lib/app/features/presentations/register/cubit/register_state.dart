import 'package:equatable/equatable.dart';
import 'package:rate_flag/app/features/data/model/user.dart';

class RegisterState extends Equatable {
  final bool isRegisterLoading;
  final bool isRegisterSuccess;
  final bool isEmailVerified;
  final String? errorMessage;

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final Gender? gender;
  final DateTime? birthDate;

  const RegisterState({
    this.isRegisterLoading = false,
    this.isRegisterSuccess = false,
    this.isEmailVerified = false,
    this.errorMessage,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.gender,
    this.birthDate,
  });

  RegisterState copyWith({
    bool? isRegisterLoading,
    bool? isRegisterSuccess,
    bool? isEmailVerified,
    String? errorMessage,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    DateTime? birthDate,
    Gender? gender,
  }) {
    return RegisterState(
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      errorMessage: errorMessage ?? this.errorMessage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
    isRegisterLoading,
    isRegisterSuccess,
    isEmailVerified,
    errorMessage,
    firstName,
    lastName,
    email,
    password,
    birthDate,
    gender,
  ];
}
