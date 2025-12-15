import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/forgot_password_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/login_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUsecase loginUserUsecase;
  final ForgotPasswordUserUsecase forgotPasswordUserUsecase;

  LoginCubit(this.loginUserUsecase, this.forgotPasswordUserUsecase)
    : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading, errorMessage: null));

    try {
      await loginUserUsecase.execute(email, password);

      emit(
        state.copyWith(loginStatus: LoginStatus.success, errorMessage: null),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'invalid-email') {
        message = "Geçerli bir e-posta giriniz";
      } else if (e.code == 'user-not-found') {
        message = "Bu e-posta ile kayıt bulunamadı";
      } else if (e.code == 'wrong-password') {
        message = "Şifre yanlış";
      } else {
        message =
            e.message ?? "E-posta doğrulaması yaptıktan sonra tekrar deneyin";
      }

      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: "Şifre yada e-posta yanlış tekrar deneyin",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: "E-posta doğrulaması yaptıktan sonra tekrar deneyin",
        ),
      );
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(
      state.copyWith(
        loginStatus: LoginStatus.initial, // ✅ EKLENECEK SATIR
        passwordResetStatus: LoginStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      await forgotPasswordUserUsecase.forgotPassword(email);

      emit(
        state.copyWith(
          passwordResetStatus: LoginStatus.success,
          errorMessage: null,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'invalid-email') {
        message = "Geçerli bir e-posta giriniz";
      } else if (e.code == 'user-not-found') {
        message = "Bu e-posta ile kayıtlı kullanıcı yok";
      } else {
        message = e.message ?? "Bir hata oluştu";
      }

      emit(
        state.copyWith(
          passwordResetStatus: LoginStatus.failure,
          errorMessage: message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          passwordResetStatus: LoginStatus.failure,
          errorMessage: "Şifre sıfırlama maili gönderilemedi",
        ),
      );
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
