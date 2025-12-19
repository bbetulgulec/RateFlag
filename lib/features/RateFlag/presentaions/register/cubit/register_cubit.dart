import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/create_user.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final CreateUser createUserUsecase;

  RegisterCubit(this.createUserUsecase) : super(const RegisterState());

  void setBirthDate(DateTime date) {
    emit(state.copyWith(birthDate: date));
  }

  Future<void> register(
    String firstName,
    String lastName,
    String mail,
    DateTime birthDate,
    String password,
  ) async {
    if (state.birthDate == null) {
      emit(state.copyWith(errorMessage: "Doğum tarihini seçmelisin"));
      return;
    }

    emit(state.copyWith(isRegisterLoading: true));

    final user = User(
      uid: "",
      firstName: firstName,
      lastName: lastName,
      mail: mail,
      birthDate: birthDate,
      password: password,
    );

    try {
      await createUserUsecase.execute(user);

      final verified = await createUserUsecase.authRepository
          .checkEmailVerified();
      if (!verified) {
        emit(
          state.copyWith(
            isRegisterLoading: false,
            isEmailVerified: false,
            errorMessage: "Lütfen e-postanızı doğrulayın",
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          isRegisterLoading: false,
          isRegisterSuccess: true,
          isEmailVerified: true,
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
