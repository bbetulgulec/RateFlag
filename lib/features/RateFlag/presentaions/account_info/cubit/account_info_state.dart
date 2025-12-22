import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/core/enum/request_status.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

class AccountInfoState extends Equatable {
  final RequestStatus getInfoStatus;
  final RequestStatus updateInfoStatus;
  final RequestStatus deleteAccountStatus;

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

    firstName,
    lastName,
    email,
    birthDate,
    gender,
  ];
}
