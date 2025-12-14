import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/login_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUsecase loginUserUsecase;

  LoginCubit(this.loginUserUsecase) : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoginLoading: true, errorMessage: null));

    try {
      // await ekleyelim ki login tamamlanana kadar beklesin
      await loginUserUsecase.execute(email, password);

      emit(
        state.copyWith(
          isLoginLoading: false,
          isLoginSuccess: true,
          errorMessage: null,
        ),
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
        message = e.message ?? "Bir hata oluştu";
      }

      emit(
        state.copyWith(
          isLoginLoading: false,
          isLoginSuccess: false,
          errorMessage: message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoginLoading: false,
          isLoginSuccess: false,
          errorMessage: "Beklenmeyen bir hata oluştu",
        ),
      );
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
