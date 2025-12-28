import 'package:rate_flag/features/rate_flag/domain/model/user.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class UpdateUserInfo {
  final FirestoreRepository firestoreRepository;

  UpdateUserInfo(this.firestoreRepository);

  Future<void> execute(User user) async {
    await firestoreRepository.updateUser(user);
  }
}
