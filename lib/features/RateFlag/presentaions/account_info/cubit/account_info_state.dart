import 'package:equatable/equatable.dart';
import '../../../domain/entity/user.dart'; // User modelini import et

class AccountInfoState extends Equatable {
  final bool isGetInfoLoading;
  final bool isUpdateInfoLoading;

  final bool isGetInfoSuccess;
  final bool isUpdateInfoSuccess;

  final String? errorMessage;
  final User? user; // artık User modeli

  final bool isDeleteAccountLoading;
  final bool isDeleteAccountSuccess;

  const AccountInfoState({
    this.isGetInfoLoading = false,
    this.isUpdateInfoLoading = false,
    this.isGetInfoSuccess = false,
    this.isUpdateInfoSuccess = false,
    this.errorMessage,
    this.user,
    this.isDeleteAccountLoading = false,
    this.isDeleteAccountSuccess = false,
  });

  AccountInfoState copyWith({
    bool? isGetInfoLoading,
    bool? isUpdateInfoLoading,
    bool? isGetInfoSuccess,
    bool? isUpdateInfoSuccess,
    String? errorMessage,
    User? user,
    bool? isDeleteAccountLoading,
    bool? isDeleteAccountSuccess,
  }) {
    return AccountInfoState(
      isGetInfoLoading: isGetInfoLoading ?? this.isGetInfoLoading,
      isUpdateInfoLoading: isUpdateInfoLoading ?? this.isUpdateInfoLoading,
      isGetInfoSuccess: isGetInfoSuccess ?? this.isGetInfoSuccess,
      isUpdateInfoSuccess: isUpdateInfoSuccess ?? this.isUpdateInfoSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      isDeleteAccountLoading:
          isDeleteAccountLoading ?? this.isDeleteAccountLoading,
      isDeleteAccountSuccess:
          isDeleteAccountSuccess ?? this.isDeleteAccountSuccess,
    );
  }

  @override
  List<Object?> get props => [
    isGetInfoLoading,
    isUpdateInfoLoading,
    isGetInfoSuccess,
    isUpdateInfoSuccess,
    errorMessage,
    user,
    isDeleteAccountLoading,
    isDeleteAccountSuccess,
  ];
}
