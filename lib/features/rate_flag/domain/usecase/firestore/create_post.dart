import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class CreatePost {
  final FirestoreRepository firestoreRepository;

  CreatePost(this.firestoreRepository);

  Future<void> execute({required Post post}) async {
    return await firestoreRepository.createPost(post);
  }
}
