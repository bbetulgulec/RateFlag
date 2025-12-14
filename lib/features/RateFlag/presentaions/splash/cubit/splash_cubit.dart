import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void startSplash() {
    emit(state.copyWith(isLoading: true));

    Timer(const Duration(seconds: 5), () {
      emit(state.copyWith(isLoading: false, isFinished: true));
    });
  }
}
