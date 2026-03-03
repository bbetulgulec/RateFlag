import 'package:rate_flag/app/features/data/domain/repositories/auth_repository.dart';
import 'package:rate_flag/app/features/data/model/user.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<User> execute(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);

      if (user == null) {
        throw Exception("Kullanıcı bulunamadı");
      }

      return user;
    } catch (e) {
      throw Exception("Giriş yapılamadı. Mailden e postayı onaylayın");
    }
  }
}
