import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class LoadPostUserUsecase {
  final FirestoreRepository repository;

  LoadPostUserUsecase(this.repository);

  Future<Post?> getPostById(String userId, String postId) {
    return repository.getPostById(userId, postId);
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) {
    return repository.getUserInfo(userId);
  }

  Future<List<Post>> loadUserPosts(String userId) {
    return repository.loadUserPosts(userId);
  }
}
