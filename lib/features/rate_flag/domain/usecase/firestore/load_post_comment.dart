import 'package:rate_flag/features/RateFlag/domain/model/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class LoadPostComment {
  final FirestoreRepository firestoreRepository;

  LoadPostComment(this.firestoreRepository);

  Future<List<Comment>> execute({required String postId}) {
    return firestoreRepository.getCommentsByPostId(postId);
  }
}
