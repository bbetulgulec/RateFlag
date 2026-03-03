import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/post.dart';

class LoadUserPosts {
  final FirestoreRepository repository;

  LoadUserPosts(this.repository);

  Future<List<Post>> execute(String userId) {
    return repository.loadUserPosts(userId);
  }
}
