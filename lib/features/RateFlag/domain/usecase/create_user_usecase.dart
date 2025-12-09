import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class CreateUserUsecase {
  final FirestoreRepository firestoreRepository;
  final AuthRepository authRepository;

  CreateUserUsecase(this.firestoreRepository, this.authRepository);

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> execute(
    String firstName,
    String lastName,
    String mail,
    DateTime birthDate,
    String password,
  ) async {
    // Firebase Auth’a kaydet
    final user = await authRepository.register(
      firstName,
      lastName,
      mail,
      birthDate,
      password,
    );

    // Firestore’a kaydet (doğrulama beklemeden)
    final String uid = user.uid;
    final Map<String, dynamic> userData = {
      "userID": uid,
      "createdAt": DateTime.now().toIso8601String(),
      "firstName": firstName,
      "lastName": lastName,
      "mail": mail,
      "birthDate": birthDate,
      "password": hashPassword(password),
    };

    await firestoreRepository.createUser("users", userData);
  }
}
