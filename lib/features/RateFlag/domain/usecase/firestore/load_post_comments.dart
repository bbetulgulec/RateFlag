import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class LoadPostComments {
  final FirestoreRepository firestoreRepository;

  LoadPostComments(this.firestoreRepository);

  Future<List<Comment>> execute({required List<String> commentIds}) async {
    if (commentIds.isEmpty) return [];

    return await firestoreRepository.getCommentsByIds(commentIds);
  }
}
