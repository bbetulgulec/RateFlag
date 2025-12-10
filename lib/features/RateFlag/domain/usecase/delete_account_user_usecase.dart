import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class DeleteAccountUserUsecase {
  final FirestoreRepository firestoreRepository;
  final AuthRepository authRepository;
  DeleteAccountUserUsecase(this.firestoreRepository, this.authRepository);

  Future<void> execute() async {
    final user = await authRepository.getCurrentUser();

    if (user == null) {
      throw Exception("Kullanıcı bulunamadı.");
    }

    final uid = user.uid;
    //Firebase Authtan sil
    await firestoreRepository.deleteAccount(uid);

    //Firebase firestoredan sil

    await authRepository.deleteAccount();
  }
}
