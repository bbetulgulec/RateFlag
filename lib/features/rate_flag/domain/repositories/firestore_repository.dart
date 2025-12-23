import 'package:rate_flag/features/RateFlag/domain/model/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/model/post.dart';
import 'package:rate_flag/features/RateFlag/domain/model/user.dart';

abstract class FirestoreRepository {
  Future<void> createUser(String collection, User user);
  Future<User?> getUserInfo(String userID);
  Future<void> updateUser(User user);
  Future<void> deleteAccount(String userID);
  Future<void> createPost(Post post);
  Future<void> createComment(Comment comment);
  Future<void> addCommentIdToPost({
    required String postId,
    required String commentId,
  });
  Future<List<Post>> loadUserPosts(String userId);
  Future<List<Post>> loadUserPrivatePosts(String userId);
  Future<List<Post>> loadAllPosts();
  Future<List<String>> getSavedPosts({required String userId});
  Future<void> incrementFlag({
    required String userId,
    required String postOwnerId,
    required Post post,
    required bool isGreen,
  });
  Future<List<Comment>> getCommentsByPostId(String postId);
  Future<Post?> getPostById(String postId);
  Future<User?> getUserById(String userId);
  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
  });
  Future<void> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  });
  Future<bool> isFollowing({
    required String currentUserId,
    required String targetUserId,
  });

  Future<List<User>> searchUserByFirstName(String name);
  Future<void> toggleSavedPost({
    required String userId,
    required String postId,
  });
  Future<List<Post>> getSavedPostsByIds(List<String> postIds);

  Future<List<Post>> loadPostsByCity(String city);

  Future<List<User>> getAllUsers();
}
