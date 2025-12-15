import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

abstract class FirestoreRepository {
  Future<void> createUser(String collection, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getUserInfo(String userID);
  Future<void> updateUserInfo(String userID, Map<String, dynamic> data);
  Future<void> deleteAccount(String userID);
  Future<void> createPost(String collection, Post post);
  Future<List<Post>> loadUserPosts(String userId);
  Future<List<Post>> loadAllPosts();

  Future<void> incrementFlag({
    required String userId,
    required String postOwnerId,
    required String postId,
    required bool isGreen,
  });
  Future<Post?> getPostById(String userId, String postId);
  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
  });
  Future<void> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  });
}
