import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class FollowUserUsecase {
  final FirestoreRepository repository;

  FollowUserUsecase(this.repository);

  Future<void> execute({
    required String currentUserId,
    required String targetUserId,
    required bool isFollow,
  }) async {
    if (isFollow) {
      await repository.followUser(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
      );
    } else {
      await repository.unfollowUser(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
      );
    }
  }

  Future<Map<String, dynamic>> getUserFollowData(String userId) async {
    final userData = await repository.getUserInfo(userId);
    return userData ?? {};
  }

  Future<bool> isFollowing({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final currentUserData = await repository.getUserInfo(currentUserId);
    final followingList = List<String>.from(
      currentUserData?['following'] ?? [],
    );

    return followingList.contains(targetUserId);
  }
}
