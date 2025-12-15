import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/check_auth_user_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckAuthUserUsecase checkAuthUsecase;
  SplashCubit(this.checkAuthUsecase) : super(const SplashState());

  void startSplash() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn = await checkAuthUsecase.execute();

    emit(
      state.copyWith(
        isLoading: false,
        isFinished: true,
        isAuthenticated: isLoggedIn,
      ),
    );
  }
}
