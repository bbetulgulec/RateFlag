import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/follow_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final LoadPostUserUsecase loadPostUserUsecase;
  final FollowUserUsecase followUserUsecase;

  ProfileCubit(this.loadPostUserUsecase, this.followUserUsecase)
    : super(const ProfileState());

  void changeTab(int index) {
    emit(state.copyWith(tabIndex: index));
  }

  Future<void> loadPosts() async {
    emit(state.copyWith(isPostLoading: true));

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final posts = await loadPostUserUsecase.loadUserPosts(userId);

      emit(
        state.copyWith(
          isPostLoading: false,
          posts: posts,
          postCount: posts.length,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isPostLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> loadUserFollowData(String userId) async {
    emit(state.copyWith(isFollowActionLoading: true));

    try {
      final userData = await followUserUsecase.getUserFollowData(userId);

      final followers = List<String>.from(userData['followers'] ?? []);
      final following = List<String>.from(userData['following'] ?? []);

      emit(
        state.copyWith(
          isFollowActionLoading: false,
          followersCount: followers.length,
          followingCount: following.length,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFollowActionLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> followUser(String targetUserId) async {
    emit(state.copyWith(isFollowActionLoading: true));
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      await followUserUsecase.execute(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
        isFollow: true,
      );
      await loadUserFollowData(currentUserId);
      emit(
        state.copyWith(
          isFollowActionLoading: false,
          isFollowActionSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFollowActionLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> unfollowUser(String targetUserId) async {
    emit(state.copyWith(isFollowActionLoading: true));
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      await followUserUsecase.execute(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
        isFollow: false,
      );
      await loadUserFollowData(currentUserId);
      emit(
        state.copyWith(
          isFollowActionLoading: false,
          isFollowActionSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFollowActionLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
