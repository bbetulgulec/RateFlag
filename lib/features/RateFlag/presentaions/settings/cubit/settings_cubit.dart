import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/sign_out_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/settings/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SignOutUserUsecase signOutUserUsecase;

  SettingsCubit(this.signOutUserUsecase) : super(SettingsState());

  Future<void> signOut() async {
    signOutUserUsecase.signOut();
  }
}
