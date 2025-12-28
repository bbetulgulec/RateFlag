import 'package:rate_flag/features/rate_flag/domain/model/comment.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';

class CreateComment {
  final FirestoreRepository firestoreRepository;

  CreateComment(this.firestoreRepository);

  Future<void> execute({required Comment comment}) async {
    return firestoreRepository.createComment(comment);
  }
}
