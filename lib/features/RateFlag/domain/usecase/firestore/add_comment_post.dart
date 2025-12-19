import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class AddCommentPost {
  final FirestoreRepository repository;

  AddCommentPost(this.repository);

  Future<void> execute({
    required String postId,
    required String commentId,
  }) async {
    await repository.addCommentIdToPost(postId: postId, commentId: commentId);
  }
}
