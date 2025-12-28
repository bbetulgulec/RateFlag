import 'package:rate_flag/features/rate_flag/domain/model/comment.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class LoadPostComment {
  final FirestoreRepository firestoreRepository;

  LoadPostComment(this.firestoreRepository);

  Future<List<Comment>> execute({required String postId}) {
    return firestoreRepository.getCommentsByPostId(postId);
  }
}
