import 'package:rate_flag/features/RateFlag/domain/model/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class CreateComment {
  final FirestoreRepository firestoreRepository;

  CreateComment(this.firestoreRepository);

  Future<void> execute({required Comment comment}) async {
    return firestoreRepository.createComment(comment);
  }
}
