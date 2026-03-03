

import 'package:rate_flag/app/features/data/domain/repositories/auth_repository.dart';
import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';

class DeleteAccount {
  final FirestoreRepository firestoreRepository;
  final AuthRepository authRepository;
  DeleteAccount(this.firestoreRepository, this.authRepository);

  Future<void> execute() async {
    final user = await authRepository.getCurrentUser();

    if (user == null) {
      throw Exception("Kullanıcı bulunamadı.");
    }

    final uid = user.uid;

    await firestoreRepository.deleteAccount(uid);

    await authRepository.deleteAccount();
  }
}
