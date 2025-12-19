import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class LoadAllPost {
  final FirestoreRepository repository;

  LoadAllPost(this.repository);

  Future<List<Post>> execute() async {
    return await repository.loadAllPosts();
  }
}
