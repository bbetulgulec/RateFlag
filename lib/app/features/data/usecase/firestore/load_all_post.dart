import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/post.dart';

class LoadAllPost {
  final FirestoreRepository repository;

  LoadAllPost(this.repository);

  Future<List<Post>> execute() async {
    return await repository.loadAllPosts();
  }
}
