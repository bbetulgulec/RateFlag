import 'package:equatable/equatable.dart';
import 'package:rate_flag/app/common/enum/request_status.dart';
import 'package:rate_flag/app/features/data/model/user.dart';

class AccountInfoState extends Equatable {
  final RequestStatus getInfoStatus;
  final RequestStatus updateInfoStatus;
  final RequestStatus deleteAccountStatus;
  final bool isFormInitialized;

  final String? errorMessage;

  final String firstName;
  final String lastName;
  final String email;
  final DateTime? birthDate;
  final Gender? gender;

  const AccountInfoState({
    this.getInfoStatus = RequestStatus.initial,
    this.updateInfoStatus = RequestStatus.initial,
    this.deleteAccountStatus = RequestStatus.initial,
    this.errorMessage,
    this.isFormInitialized = false,

    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.birthDate,
    this.gender,
  });

  AccountInfoState copyWith({
    RequestStatus? getInfoStatus,
    RequestStatus? updateInfoStatus,
    RequestStatus? deleteAccountStatus,
    String? errorMessage,
    bool? isFormInitialized,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthDate,
    Gender? gender,
  }) {
    return AccountInfoState(
      errorMessage: errorMessage ?? this.errorMessage,

      getInfoStatus: getInfoStatus ?? this.getInfoStatus,
      updateInfoStatus: updateInfoStatus ?? this.updateInfoStatus,
      deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
      isFormInitialized: isFormInitialized ?? this.isFormInitialized,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    getInfoStatus,
    updateInfoStatus,
    deleteAccountStatus,
    isFormInitialized,
    firstName,
    lastName,
    email,
    birthDate,
    gender,
  ];
}
