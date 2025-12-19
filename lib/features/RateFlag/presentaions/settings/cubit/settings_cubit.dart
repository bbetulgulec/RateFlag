import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/auth/sign_out.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SignOut signOutUserUsecase;

  SettingsCubit(this.signOutUserUsecase) : super(SettingsState());

  Future<void> signOut() async {
    signOutUserUsecase.signOut();
  }
}
