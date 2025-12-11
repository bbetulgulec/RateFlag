import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

abstract class FirestoreRepository {
  Future<void> createUser(String collection, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getUserInfo(String userID);
  Future<void> updateUserInfo(String userID, Map<String, dynamic> data);
  Future<void> deleteAccount(String userID);
  Future<void> createPost(
    String collection,
    Map<String, dynamic> data,
    Post post,
  );
}
