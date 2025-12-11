import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

class SignOutUserUsecase {
  final AuthRepository authRepository;
  SignOutUserUsecase(this.authRepository);

  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
