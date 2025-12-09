import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/create_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final CreateUserUsecase createUserUsecase;

  RegisterCubit(this.createUserUsecase) : super(const RegisterState());

  // Doğum tarihi cubitte tutulacak
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

    emit(state.copyWith(isRegisterLoading: true, errorMessage: null));

    try {
      await createUserUsecase.execute(
        firstName,
        lastName,
        mail,
        state.birthDate!,
        password,
      );

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
