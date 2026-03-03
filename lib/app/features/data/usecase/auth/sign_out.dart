
import 'package:rate_flag/app/features/data/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository authRepository;
  SignOut(this.authRepository);

  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
