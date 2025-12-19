import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class GetUserFollowData {
  final FirestoreRepository repository;

  GetUserFollowData(this.repository);

  // Future<Map<String, dynamic>> execute(String userId) async {
  // final userData = await repository.getUserInfo(userId);
  //return userData ?? {};
  //}
}
