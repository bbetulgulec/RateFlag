import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class LoadUserPosts {
  final FirestoreRepository repository;

  LoadUserPosts(this.repository);

  Future<List<Post>> execute(String userId) {
    return repository.loadUserPosts(userId);
  }
}
