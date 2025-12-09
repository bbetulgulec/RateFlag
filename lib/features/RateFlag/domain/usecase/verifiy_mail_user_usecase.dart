import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class VerifyAndSaveUserUsecase {
  final FirestoreRepository firestoreRepository;
  final AuthRepository authRepository;

  VerifyAndSaveUserUsecase(this.firestoreRepository, this.authRepository);

  Future<void> execute(
    String firstName,
    String lastName,
    String mail,
    DateTime birthDate,
    String password,
  ) async {
    // 1️⃣ Email doğrulandı mı?
    final bool isVerified = await authRepository.checkEmailVerified();

    if (!isVerified) {
      throw Exception("Lütfen e-mailinizi doğrulayın.");
    }

    // 2️⃣ auth’dan UID al
    final firebaseUser = await authRepository.getCurrentUser();
    final String uid = firebaseUser!.uid;

    // 3️⃣ Firestore'a kaydet
    final data = {
      "userID": uid,
      "createdAt": DateTime.now().toIso8601String(),
      "firstName": firstName,
      "lastName": lastName,
      "mail": mail,
      "birthDate": birthDate,
      "password": password,
    };

    await firestoreRepository.createUser("users", data);
  }
}
