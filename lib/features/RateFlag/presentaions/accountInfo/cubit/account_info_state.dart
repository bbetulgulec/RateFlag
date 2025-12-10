import 'package:equatable/equatable.dart';

class AccountInfoState extends Equatable {
  final bool isGetInfoLoading;
  final bool isUpdateInfoLoading;

  final bool isGetInfoSuccess;
  final bool isUpdateInfoSuccess;

  final String? errorMessage;
  final Map<String, dynamic>? userData; // EKLENDİ
  final DateTime? birthDate;

  const AccountInfoState({
    this.isGetInfoLoading = false,
    this.isUpdateInfoLoading = false,
    this.isGetInfoSuccess = false,
    this.isUpdateInfoSuccess = false,
    this.errorMessage,
    this.userData,
    this.birthDate,
  });

  AccountInfoState copyWith({
    bool? isGetInfoLoading,
    bool? isUpdateInfoLoading,
    bool? isGetInfoSuccess,
    bool? isUpdateInfoSuccess,
    String? errorMessage,
    Map<String, dynamic>? userData,
    DateTime? birthDate,
  }) {
    return AccountInfoState(
      isGetInfoLoading: isGetInfoLoading ?? this.isGetInfoLoading,
      isUpdateInfoLoading: isUpdateInfoLoading ?? this.isUpdateInfoLoading,
      isGetInfoSuccess: isGetInfoSuccess ?? false,
      isUpdateInfoSuccess: isUpdateInfoSuccess ?? false,
      errorMessage: errorMessage,
      userData: userData ?? this.userData,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props => [
    isGetInfoLoading,
    isUpdateInfoLoading,
    isGetInfoSuccess,
    isUpdateInfoSuccess,
    errorMessage,
    userData,
    birthDate,
  ];
}
