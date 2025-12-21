import 'package:equatable/equatable.dart';
import '../../../domain/entity/user.dart';

class AccountInfoState extends Equatable {
  final bool isGetInfoLoading;
  final bool isUpdateInfoLoading;

  final bool isGetInfoSuccess;
  final bool isUpdateInfoSuccess;

  final String? errorMessage;

  final bool isDeleteAccountLoading;
  final bool isDeleteAccountSuccess;

  final String firstName;
  final String lastName;
  final String email;
  final DateTime? birthDate;
  final Gender? gender;

  const AccountInfoState({
    this.isGetInfoLoading = false,
    this.isUpdateInfoLoading = false,
    this.isGetInfoSuccess = false,
    this.isUpdateInfoSuccess = false,
    this.errorMessage,

    this.isDeleteAccountLoading = false,
    this.isDeleteAccountSuccess = false,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.birthDate,
    this.gender,
  });

  AccountInfoState copyWith({
    bool? isGetInfoLoading,
    bool? isUpdateInfoLoading,
    bool? isGetInfoSuccess,
    bool? isUpdateInfoSuccess,
    String? errorMessage,

    bool? isDeleteAccountLoading,
    bool? isDeleteAccountSuccess,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthDate,
    Gender? gender,
  }) {
    return AccountInfoState(
      isGetInfoLoading: isGetInfoLoading ?? this.isGetInfoLoading,
      isUpdateInfoLoading: isUpdateInfoLoading ?? this.isUpdateInfoLoading,
      isGetInfoSuccess: isGetInfoSuccess ?? this.isGetInfoSuccess,
      isUpdateInfoSuccess: isUpdateInfoSuccess ?? this.isUpdateInfoSuccess,
      errorMessage: errorMessage ?? this.errorMessage,

      isDeleteAccountLoading:
          isDeleteAccountLoading ?? this.isDeleteAccountLoading,
      isDeleteAccountSuccess:
          isDeleteAccountSuccess ?? this.isDeleteAccountSuccess,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
    isGetInfoLoading,
    isUpdateInfoLoading,
    isGetInfoSuccess,
    isUpdateInfoSuccess,
    errorMessage,

    isDeleteAccountLoading,
    isDeleteAccountSuccess,
    firstName,
    lastName,
    email,
    birthDate,
    gender,
  ];
}
