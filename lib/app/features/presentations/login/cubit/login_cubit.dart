import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/app/features/data/usecase/auth/forgot_password_user.dart';
import 'package:rate_flag/app/features/data/usecase/auth/login_user.dart';
import 'package:rate_flag/app/features/presentations/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUserUsecase;
  final ForgotPasswordUser forgotPasswordUserUsecase;

  LoginCubit(this.loginUserUsecase, this.forgotPasswordUserUsecase)
    : super(const LoginState());

  void emailChanged(String email) => emit(state.copyWith(email: email));

  void passwordChanged(String password) =>
      emit(state.copyWith(password: password));

  Future<void> login() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(
        state.copyWith(errorMessage: TextConstants.dontEmptyEmailAndPassword),
      );
      return;
    }

    emit(state.copyWith(loginStatus: LoginStatus.loading, errorMessage: null));
    try {
      await loginUserUsecase.execute(state.email.trim(), state.password.trim());

      emit(state.copyWith(loginStatus: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: e.toString().replaceFirst(
            '${TextConstants.error}: ',
            '',
          ),
        ),
      );
    }
  }

  Future<void> forgotPassword() async {
    if (state.email.isEmpty) {
      emit(state.copyWith(errorMessage: TextConstants.plaseEnterEmail));
      return;
    }

    emit(
      state.copyWith(
        passwordResetStatus: LoginStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      await forgotPasswordUserUsecase.execute(state.email.trim());

      emit(state.copyWith(passwordResetStatus: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          passwordResetStatus: LoginStatus.failure,
          errorMessage: e.toString().replaceFirst(
            '${TextConstants.error}: ',
            '',
          ),
        ),
      );
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
