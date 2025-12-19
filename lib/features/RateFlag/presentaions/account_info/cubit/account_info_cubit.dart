import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/delete_account.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/update_user_info.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState> {
  final UpdateUserInfo updateUserInfoUsecase;
  final DeleteAccount deleteAccountUsecase;
  final GetUserInfo getUserInfoUsecase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mailController = TextEditingController();
  final dateController = TextEditingController();

  AccountInfoCubit(
    this.updateUserInfoUsecase,
    this.deleteAccountUsecase,
    this.getUserInfoUsecase,
  ) : super(const AccountInfoState());

  // ------------------ HELPERS ------------------

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // ------------------ LOAD USER ------------------

  Future<void> loadUser(String userID) async {
    emit(state.copyWith(isGetInfoLoading: true, errorMessage: null));

    try {
      final user = await getUserInfoUsecase.execute(userID);

      if (user == null) {
        emit(
          state.copyWith(
            isGetInfoLoading: false,
            errorMessage: "Kullanıcı bulunamadı",
          ),
        );
        return;
      }

      // Controller'ları doldur
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      mailController.text = user.mail;
      dateController.text = _formatDate(user.birthDate);

      // ✅ EN KRİTİK SATIR
      emit(
        state.copyWith(
          isGetInfoLoading: false,
          isGetInfoSuccess: true,
          user: user,
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

  // ------------------ UPDATE USER ------------------

  Future<void> updateUser(String userID) async {
    final currentUser = state.user;
    if (currentUser == null) {
      emit(state.copyWith(errorMessage: "Kullanıcı bilgisi bulunamadı"));
      return;
    }

    emit(
      state.copyWith(
        isUpdateInfoLoading: true,
        isUpdateInfoSuccess: false,
        errorMessage: null,
      ),
    );

    try {
      final updatedUser = currentUser.copyWith(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        mail: mailController.text.trim(),
        // birthDate UI’dan seçildiği için state’te zaten DateTime
        birthDate: currentUser.birthDate,
      );

      await updateUserInfoUsecase.execute(updatedUser);

      emit(
        state.copyWith(
          isUpdateInfoLoading: false,
          isUpdateInfoSuccess: true,
          user: updatedUser,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isUpdateInfoLoading: false,
          errorMessage: "Güncelleme sırasında hata oluştu",
        ),
      );
    }
  }

  // ------------------ DELETE USER ------------------

  Future<void> deleteUser(String userID) async {
    emit(state.copyWith(isDeleteAccountLoading: true, errorMessage: null));

    try {
      await deleteAccountUsecase.execute();

      emit(
        state.copyWith(
          isDeleteAccountLoading: false,
          isDeleteAccountSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isDeleteAccountLoading: false,
          errorMessage: "Hesap silinemedi",
        ),
      );
    }
  }

  // ------------------ CLEANUP ------------------

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    mailController.dispose();
    dateController.dispose();
    return super.close();
  }
}
