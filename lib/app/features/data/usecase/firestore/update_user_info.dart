import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/user.dart';

class UpdateUserInfo {
  final FirestoreRepository firestoreRepository;

  UpdateUserInfo(this.firestoreRepository);

  Future<void> execute(User user) async {
    await firestoreRepository.updateUser(user);
  }
}
