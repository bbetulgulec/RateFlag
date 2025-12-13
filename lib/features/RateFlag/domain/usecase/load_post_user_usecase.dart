import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class LoadPostUserUsecase {
  final FirestoreRepository firestoreRepository;

  LoadPostUserUsecase(this.firestoreRepository);

  Future<List<Post>> execute(String userId) async {
    return await firestoreRepository.loadUserPosts(userId);
  }
}
