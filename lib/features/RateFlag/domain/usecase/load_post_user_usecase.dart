import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class LoadPostUserUsecase {
  final FirestoreRepository firestoreRepository;

  LoadPostUserUsecase(this.firestoreRepository);

  Future<List<Post>> execute(String userId) async {
    return await firestoreRepository.loadUserPosts(userId);
  }

  Future<Post?> executeGetPostByIdUsecase(String userId, String postId) async {
    return await firestoreRepository.getPostById(userId, postId);
  }

  Future<Post?> getPostById(String userId, String postId) {
    return firestoreRepository.getPostById(userId, postId);
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) {
    return firestoreRepository.getUserInfo(userId); // 🔥 BURASI
  }
}
