import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/forgot_password_user.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/login_user.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUserUsecase;
  final ForgotPasswordUser forgotPasswordUserUsecase;

  LoginCubit(this.loginUserUsecase, this.forgotPasswordUserUsecase)
    : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading, errorMessage: null));

    try {
      await loginUserUsecase.execute(email, password);

      emit(state.copyWith(loginStatus: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(
      state.copyWith(
        passwordResetStatus: LoginStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      await forgotPasswordUserUsecase.execute(email);

      emit(state.copyWith(passwordResetStatus: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          passwordResetStatus: LoginStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
