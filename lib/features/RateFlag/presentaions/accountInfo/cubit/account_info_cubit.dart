import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/delete_account_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/update_info_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/accountInfo/cubit/account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState> {
  final UpdateInfoUserUsecase updateInfoUserUsecase;
  final DeleteAccountUserUsecase deleteAccountUserUsecase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mailController = TextEditingController();
  final dateController = TextEditingController();

  AccountInfoCubit(this.updateInfoUserUsecase, this.deleteAccountUserUsecase)
    : super(const AccountInfoState());

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // Doğum tarihi cubitte tutulacak
  void setBirthDate(DateTime date) {
    emit(state.copyWith(birthDate: date));
  }

  Future<void> loadUser(String userID) async {
    emit(state.copyWith(isGetInfoLoading: true, errorMessage: null));

    try {
      final userData = await updateInfoUserUsecase.fetchUser(userID);

      if (userData == null) {
        emit(
          state.copyWith(
            isGetInfoLoading: false,
            errorMessage: "Kullanıcı bulunamadı",
            isGetInfoSuccess: false,
          ),
        );
        return;
      }

      /// TEXT FIELD'LARI DOLDUR
      firstNameController.text = userData["firstName"] ?? "";
      lastNameController.text = userData["lastName"] ?? "";
      mailController.text = userData["mail"] ?? "";
      final birth = userData["birthDate"];

      dateController.text = birth is Timestamp
          ? _formatDate(birth.toDate())
          : (birth ?? "");

      emit(
        state.copyWith(
          isGetInfoLoading: false,
          isGetInfoSuccess: true,
          userData: userData,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isGetInfoLoading: false,
          errorMessage: "Bilgiler alınırken hata oluştu",
        ),
      );
    }
  }

  Future<void> updateUser(String userID) async {
    emit(state.copyWith(isUpdateInfoLoading: true));

    try {
      final newData = {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "mail": mailController.text.trim(),
        "birthDate": dateController.text.trim(),
      };

      await updateInfoUserUsecase.updateUser(userID, newData);

      emit(
        state.copyWith(isUpdateInfoLoading: false, isUpdateInfoSuccess: true),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isUpdateInfoLoading: false,
          errorMessage: "Güncelleme sırasında bir hata oluştu",
        ),
      );
    }
  }

  Future<void> deleteUser(String userID) async {
    emit(state.copyWith(isDeleteAccountLoading: true));

    try {
      await deleteAccountUserUsecase.execute();
      emit(
        state.copyWith(
          isDeleteAccountSuccess: true,
          isDeleteAccountLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isDeleteAccountLoading: false,
          isDeleteAccountSuccess: false,
          errorMessage: "Kullanıcı silinemedi : $e",
        ),
      );
    }
  }
}
