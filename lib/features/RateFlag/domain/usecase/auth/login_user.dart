import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';

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
      throw Exception("Giriş yapılamadı. Mailden epostayı onaylayın");
    }
  }
}
