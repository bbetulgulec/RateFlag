import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/delete_account.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/update_user_info.dart';
import 'package:rate_flag/features/RateFlag/presentaions/account_info/cubit/account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState> {
  final UpdateUserInfo updateUserInfoUsecase;
  final DeleteAccount deleteAccountUsecase;
  final GetUserInfo getUserInfoUsecase;

  AccountInfoCubit(
    this.updateUserInfoUsecase,
    this.deleteAccountUsecase,
    this.getUserInfoUsecase,
  ) : super(const AccountInfoState());

  void firstNameChanged(String value) {
    emit(state.copyWith(firstName: value));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(lastName: value));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void birthDateChanged(DateTime date) {
    emit(state.copyWith(birthDate: date));
  }

  void genderChanged(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

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

      emit(
        state.copyWith(
          isGetInfoLoading: false,
          isGetInfoSuccess: true,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.mail,
          birthDate: user.birthDate,
          gender: user.gender,
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
    emit(
      state.copyWith(
        isUpdateInfoLoading: true,
        isUpdateInfoSuccess: false,
        errorMessage: null,
      ),
    );

    try {
      final updatedUser = User(
        uid: userID,
        firstName: state.firstName.trim(),
        lastName: state.lastName.trim(),
        mail: state.email.trim(),
        birthDate: state.birthDate!,
        gender: state.gender!,
        password: '',
      );

      await updateUserInfoUsecase.execute(updatedUser);

      emit(
        state.copyWith(isUpdateInfoLoading: false, isUpdateInfoSuccess: true),
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
}
