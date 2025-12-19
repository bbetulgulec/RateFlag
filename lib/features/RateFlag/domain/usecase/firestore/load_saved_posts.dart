import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class LoadSavedPosts {
  final FirestoreRepository firestoreRepository;

  LoadSavedPosts(this.firestoreRepository);

  Future<List<Post>> execute(List<String> postIds) async {
    return await firestoreRepository.getSavedPostsByIds(postIds);
  }
}
