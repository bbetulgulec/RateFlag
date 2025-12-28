import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class LoadPostById {
  final FirestoreRepository repository;

  LoadPostById(this.repository);

  Future<Post?> execute(String postId) {
    return repository.getPostById(postId);
  }
}
