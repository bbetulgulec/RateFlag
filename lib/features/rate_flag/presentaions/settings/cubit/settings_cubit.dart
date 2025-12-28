import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/domain/usecase/auth/sign_out.dart';
import 'package:rate_flag/features/rate_flag/presentaions/settings/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SignOut signOutUserUsecase;

  SettingsCubit(this.signOutUserUsecase) : super(SettingsState());

  Future<void> signOut() async {
    emit(state.copyWith(isSignOutLoading: true, errorMessage: null));
    try {
      await signOutUserUsecase.signOut();
      emit(state.copyWith(isSignOutLoading: false, isSignOutSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSignOutLoading: false, errorMessage: e.toString()));
    }
  }
}
