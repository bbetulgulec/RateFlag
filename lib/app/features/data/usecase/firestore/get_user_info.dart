import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/user.dart';

class GetUserInfo {
  final FirestoreRepository firestoreRepository;

  GetUserInfo(this.firestoreRepository);

  Future<User?> execute(String userId) async {
    return await firestoreRepository.getUserInfo(userId);
  }
}
