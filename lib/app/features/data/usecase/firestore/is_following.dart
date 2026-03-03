
import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';

class IsFollowing {
  final FirestoreRepository firestoreRepository;
  IsFollowing(this.firestoreRepository);

  Future<bool> execute({
    required String currentUserId,
    required String targetUserId,
  }) async {
    // Firestore’dan currentUser’ı al
    final currentUser = await firestoreRepository.getUserById(currentUserId);

    if (currentUser == null) {
      // User yoksa takip yok demek
      return false;
    }

    // Following listesi içinde targetUserId var mı?
    final followingList = currentUser.following ?? [];
    return followingList.contains(targetUserId);
  }
}
