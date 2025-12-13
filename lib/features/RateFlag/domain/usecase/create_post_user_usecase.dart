import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class CreatePostUserUsecase {
  final FirestoreRepository firestoreRepository;

  CreatePostUserUsecase(this.firestoreRepository);

  Future<void> execute({
    required String collection,
    required Map<String, dynamic> data,
    required Post post,
  }) async {
    return await firestoreRepository.createPost(collection, post);
  }
}
