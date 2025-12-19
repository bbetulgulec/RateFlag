import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

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
  Future<List<Comment>> getCommentsByIds(List<String> commentIds);
  Future<List<Post>> loadUserPosts(String userId);
  Future<List<Post>> loadUserPrivatePosts(String userId);
  Future<List<Post>> loadAllPosts();

  Future<void> incrementFlag({
    required String userId,
    required String postOwnerId,
    required Post post,
    required bool isGreen,
  });
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

  Future<void> toggleSavedPost({
    required String userId,
    required String postId,
  });
  Future<List<Post>> getSavedPostsByIds(List<String> postIds);
}
