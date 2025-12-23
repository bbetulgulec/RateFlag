import 'package:rate_flag/features/RateFlag/domain/model/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class CreateUser {
  final AuthRepository authRepository;
  final FirestoreRepository firestoreRepository;

  CreateUser(this.authRepository, this.firestoreRepository);

  Future<void> execute(User user) async {
    // 1️⃣ Auth → uid al
    final uid = await authRepository.register(user.mail, user.password);

    // 2️⃣ User objesini uid ile güncelle
    final createdUser = user.copyWith(uid: uid);

    // 3️⃣ Firestore’a kaydet (TEK GERÇEK USER)
    await firestoreRepository.createUser("users", createdUser);
  }
}
