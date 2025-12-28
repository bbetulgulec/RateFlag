import 'package:rate_flag/features/rate_flag/domain/repositories/auth_repository.dart';

class CheckAuthUser {
  final AuthRepository repository;

  CheckAuthUser(this.repository);

  Future<bool> execute() async {
    final user = await repository.getCurrentUser();
    return user != null;
  }
}
