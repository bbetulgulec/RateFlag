import 'package:rate_flag/app/features/data/model/user.dart';

abstract class AuthRepository {
  Future<String> register(String email, String password);
  Future<void> sendEmailVerification();
  Future<bool> checkEmailVerified();
  Future<User?> login(String email, String password);

  Future<void> forgotPassword(String email);
  Future<User?> getCurrentUser();
  Future<void> deleteAccount();
  Future<void> signOut();
}
