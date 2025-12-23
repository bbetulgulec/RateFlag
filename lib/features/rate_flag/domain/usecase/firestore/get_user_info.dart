import 'package:rate_flag/features/RateFlag/domain/model/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class GetUserInfo {
  final FirestoreRepository firestoreRepository;

  GetUserInfo(this.firestoreRepository);

  Future<User?> execute(String userId) async {
    return await firestoreRepository.getUserInfo(userId);
  }
}
