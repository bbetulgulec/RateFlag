import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/app/features/data/model/user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/create_user.dart';
import 'package:rate_flag/app/features/presentations/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final CreateUser createUserUsecase;

  RegisterCubit(this.createUserUsecase) : super(const RegisterState());

  void firstNameChanged(String value) => emit(state.copyWith(firstName: value));

  void lastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void emailChanged(String value) => emit(state.copyWith(email: value));

  void passwordChanged(String value) => emit(state.copyWith(password: value));

  void setBirthDate(DateTime date) {
    emit(state.copyWith(birthDate: date));
  }

  void setGender(Gender gender) => emit(state.copyWith(gender: gender));

  Future<void> register() async {
    if (state.firstName.isEmpty ||
        state.lastName.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty) {
      emit(state.copyWith(errorMessage: TextConstants.fullAllFlield));
      return;
    }

    if (state.birthDate == null) {
      emit(state.copyWith(errorMessage: TextConstants.chooseYourBirthDay));
      return;
    }

    if (state.gender == null) {
      emit(state.copyWith(errorMessage: TextConstants.chooseYourGender));
      return;
    }

    emit(state.copyWith(isRegisterLoading: true));

    final user = User(
      uid: "",
      firstName: state.firstName,
      lastName: state.lastName,
      mail: state.email,
      birthDate: state.birthDate!,
      password: state.password,
      gender: state.gender!,
    );

    try {
      await createUserUsecase.execute(user);

      await createUserUsecase.authRepository.sendEmailVerification();

      emit(
        state.copyWith(
          isRegisterLoading: false,
          isRegisterSuccess: true,
          errorMessage: TextConstants.plaseVerifyEmail,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isRegisterLoading: false, errorMessage: e.toString()),
      );
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
