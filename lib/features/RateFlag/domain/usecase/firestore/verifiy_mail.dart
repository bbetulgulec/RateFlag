import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class VerifyMail {
  final FirestoreRepository firestoreRepository;
  final AuthRepository authRepository;

  VerifyMail(this.firestoreRepository, this.authRepository);

  Future<void> execute(
    String firstName,
    String lastName,
    String mail,
    DateTime birthDate,
    String password,
  ) async {
    final bool isVerified = await authRepository.checkEmailVerified();

    if (!isVerified) {
      throw Exception("Lütfen e-mailinizi doğrulayın.");
    }

    final firebaseUser = await authRepository.getCurrentUser();
    final String uid = firebaseUser!.uid;

    final data = {
      "userID": uid,
      "createdAt": DateTime.now().toIso8601String(),
      "firstName": firstName,
      "lastName": lastName,
      "mail": mail,
      "birthDate": birthDate,
      "password": password,
    };

    // await firestoreRepository.createUser("users", user);
  }
}
