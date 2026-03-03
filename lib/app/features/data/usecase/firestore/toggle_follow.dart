
import 'package:rate_flag/app/features/data/domain/repositories/firestore_repository.dart';

class ToggleFollows {
  final FirestoreRepository repository;
  ToggleFollows(this.repository);

  Future<void> execute({
    required String currentUserId,
    required String targetUserId,
    required bool isFollow,
  }) async {
    if (isFollow) {
      // model bazlı takip
      final currentUser = await repository.getUserById(currentUserId);
      final targetUser = await repository.getUserById(targetUserId);

      if (currentUser == null || targetUser == null) return;

      final updatedCurrent = currentUser.copyWith(
        following: [
          ...?currentUser.following,
          if (!(currentUser.following ?? []).contains(targetUserId))
            targetUserId,
        ],
      );

      final updatedTarget = targetUser.copyWith(
        followers: [
          ...?targetUser.followers,
          if (!(targetUser.followers ?? []).contains(currentUserId))
            currentUserId,
        ],
      );

      await repository.updateUser(updatedCurrent);
      await repository.updateUser(updatedTarget);
    } else {
      // model bazlı takipten çık
      final currentUser = await repository.getUserById(currentUserId);
      final targetUser = await repository.getUserById(targetUserId);

      if (currentUser == null || targetUser == null) return;

      final updatedCurrent = currentUser.copyWith(
        following: (currentUser.following ?? [])
            .where((id) => id != targetUserId)
            .toList(),
      );

      final updatedTarget = targetUser.copyWith(
        followers: (targetUser.followers ?? [])
            .where((id) => id != currentUserId)
            .toList(),
      );

      await repository.updateUser(updatedCurrent);
      await repository.updateUser(updatedTarget);
    }
  }
}
