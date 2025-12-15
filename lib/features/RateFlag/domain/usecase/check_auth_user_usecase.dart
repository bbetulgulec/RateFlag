import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

class CheckAuthUserUsecase {
  final AuthRepository repository;

  CheckAuthUserUsecase(this.repository);

  Future<bool> execute() async {
    final user = await repository.getCurrentUser();
    return user != null;
  }
}
