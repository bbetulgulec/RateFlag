import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/app/features/data/model/comment.dart';

class CreateComment {
  final FirestoreRepository firestoreRepository;

  CreateComment(this.firestoreRepository);

  Future<void> execute({required Comment comment}) async {
    return firestoreRepository.createComment(comment);
  }
}
