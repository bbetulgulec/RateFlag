import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class RateTheImageUserUsecase {
  final FirestoreRepository firestoreRepository;

  RateTheImageUserUsecase(this.firestoreRepository);

  Future<void> execute({
    required String userId,
    required String postOwnerId,
    required String postId,
    required bool isGreen,
  }) async {
    await firestoreRepository.incrementFlag(
      userId: userId,
      postOwnerId: postOwnerId,
      postId: postId,
      isGreen: isGreen,
    );
  }
}
