import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/app/common/enum/request_status.dart';
import 'package:rate_flag/app/features/data/model/user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/delete_account.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/update_user_info.dart';
import 'package:rate_flag/app/features/presentations/account_info/cubit/account_info_state.dart';

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
    emit(
      state.copyWith(getInfoStatus: RequestStatus.loading, errorMessage: null),
    );

    try {
      final user = await getUserInfoUsecase.execute(userID);

      if (user == null) {
        emit(
          state.copyWith(
            getInfoStatus: RequestStatus.failure,
            errorMessage: TextConstants.doNotFoundPerson,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          getInfoStatus: RequestStatus.success,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.mail,
          birthDate: user.birthDate,
          gender: user.gender,
          isFormInitialized: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          getInfoStatus: RequestStatus.failure,
          errorMessage: TextConstants.doTakeInfoHaveError,
        ),
      );
    }
  }

  Future<void> updateUser(String userID) async {
    emit(
      state.copyWith(
        updateInfoStatus: RequestStatus.loading,
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

      emit(state.copyWith(updateInfoStatus: RequestStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          updateInfoStatus: RequestStatus.failure,
          errorMessage: TextConstants.doHaveErrorForUpdate,
        ),
      );
    }
  }

  Future<void> deleteUser(String userID) async {
    emit(
      state.copyWith(
        deleteAccountStatus: RequestStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      await deleteAccountUsecase.execute();

      emit(state.copyWith(deleteAccountStatus: RequestStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          deleteAccountStatus: RequestStatus.failure,
          errorMessage: TextConstants.didNotDeleteAccount,
        ),
      );
    }
  }
}
