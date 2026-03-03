
import 'package:rate_flag/app/features/data/domain/repositories/auth_repository.dart';

class ForgotPasswordUser {
  AuthRepository authRepository;

  ForgotPasswordUser(this.authRepository);

  Future<void> execute(String email) async {
    await authRepository.forgotPassword(email);
  }
}
