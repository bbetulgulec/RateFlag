import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/post.dart';

class CreatePost {
  final FirestoreRepository firestoreRepository;

  CreatePost(this.firestoreRepository);

  Future<void> execute({required Post post}) async {
    return await firestoreRepository.createPost(post);
  }
}
