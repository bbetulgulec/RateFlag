import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/check_auth_user.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckAuthUser checkAuthUsecase;
  SplashCubit(this.checkAuthUsecase) : super(const SplashState());

  Future<void> init() async {
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
