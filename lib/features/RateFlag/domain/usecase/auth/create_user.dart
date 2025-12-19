import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/auth_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class CreateUser {
  final AuthRepository authRepository;
  final FirestoreRepository firestoreRepository;

  CreateUser(this.authRepository, this.firestoreRepository);

  Future<void> execute(User user) async {
    // 1. Firebase Auth
    final authUser = await authRepository.register(user.mail, user.password);

    // 2. UID'yi modele ekle
    final createdUser = user.copyWith(uid: authUser.uid);

    // 3. Firestore'a kaydet
    await firestoreRepository.createUser("users", createdUser);
  }
}
