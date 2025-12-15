import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

class ForgotPasswordUserUsecase {
  AuthRepository authRepository;

  ForgotPasswordUserUsecase(this.authRepository);

  Future<void> forgotPassword(String email) async {
    await authRepository.forgotPassword(email);
  }
}
