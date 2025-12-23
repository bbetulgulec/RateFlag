import 'package:rate_flag/features/RateFlag/domain/model/post.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class RatePost {
  final FirestoreRepository firestoreRepository;

  RatePost(this.firestoreRepository);

  Future<void> execute({
    required String userId,
    required Post post, // artık Post modelini alıyoruz
    required bool isGreen,
  }) async {
    await firestoreRepository.incrementFlag(
      userId: userId,
      postOwnerId: post.userId,
      post: post,
      isGreen: isGreen,
    );
  }
}
