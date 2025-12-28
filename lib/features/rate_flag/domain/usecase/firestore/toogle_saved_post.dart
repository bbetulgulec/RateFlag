import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class ToggleSavedPost {
  final FirestoreRepository firestoreRepository;

  ToggleSavedPost(this.firestoreRepository);

  Future<void> execute({required String userId, required String postId}) async {
    await firestoreRepository.toggleSavedPost(userId: userId, postId: postId);
  }
}
