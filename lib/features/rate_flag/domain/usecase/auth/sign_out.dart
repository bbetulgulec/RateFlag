import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository authRepository;
  SignOut(this.authRepository);

  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
