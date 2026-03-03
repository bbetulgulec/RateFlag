import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/post.dart';

class LoadPostById {
  final FirestoreRepository repository;

  LoadPostById(this.repository);

  Future<Post?> execute(String postId) {
    return repository.getPostById(postId);
  }
}
