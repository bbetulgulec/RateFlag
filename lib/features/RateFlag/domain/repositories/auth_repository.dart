import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

abstract class AuthRepository {
  Future<User> register(
    String firstName,
    String lastName,
    String mail,
    DateTime age,
    String password,
  );
  Future<bool> checkEmailVerified();
  Future<User?> login(String email, String password);

  Future<User?> getCurrentUser();
  Future<void> deleteAccount();
  Future<void> signOut();
}
