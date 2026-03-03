import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/comment.dart';

class LoadPostComment {
  final FirestoreRepository firestoreRepository;

  LoadPostComment(this.firestoreRepository);

  Future<List<Comment>> execute({required String postId}) {
    return firestoreRepository.getCommentsByPostId(postId);
  }
}
