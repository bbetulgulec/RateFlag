import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/follow_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/rate_the_image_user_usecase.dart';
import 'post_info_state.dart';

class PostInfoCubit extends Cubit<PostInfoState> {
  final LoadPostUserUsecase loadPostUserUsecase;
  final RateTheImageUserUsecase rateTheImageUserUsecase;
  final FollowUserUsecase followUserUsecase;

  PostInfoCubit(
    this.loadPostUserUsecase,
    this.rateTheImageUserUsecase,
    this.followUserUsecase,
  ) : super(PostInfoState());

  Future<void> loadPostInfo({
    required String userId,
    required String postId,
  }) async {
    emit(state.copyWith(isLoadPostInfoLoading: true, errorMessage: null));

    try {
      // 🔥 1. Postu çek
      final post = await loadPostUserUsecase.getPostById(userId, postId);
      if (post == null) {
        emit(
          state.copyWith(
            isLoadPostInfoLoading: false,
            errorMessage: "Post bulunamadı",
          ),
        );
        return;
      }

      // 🔥 2. Kullanıcı bilgilerini çek
      final user = await loadPostUserUsecase.getUserInfo(post.userId);
      if (user == null) {
        emit(
          state.copyWith(
            isLoadPostInfoLoading: false,
            errorMessage: "Kullanıcı bulunamadı",
          ),
        );
        return;
      }

      // 🔥 3. Takip durumunu kontrol et
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final isFollowing = await followUserUsecase.isFollowing(
        currentUserId: currentUserId,
        targetUserId: post.userId,
      );

      // 🔥 4. State’i güncelle
      emit(
        state.copyWith(
          post: post,
          user: user,
          isFollowing: isFollowing,
          isLoadPostInfoLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadPostInfoLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> ratePost({
    required String currentUserId,
    required bool isGreen,
  }) async {
    final post = state.post;
    if (post == null) return;

    final prevRed = state.redFlagCount ?? post.redFlag;
    final prevGreen = state.greenFlagCount ?? post.greenFlag;

    // 🔥 OPTIMISTIC UI
    emit(
      state.copyWith(
        redFlagCount: isGreen ? prevRed : prevRed! + 1,
        greenFlagCount: isGreen ? prevGreen! + 1 : prevGreen,
      ),
    );

    try {
      await rateTheImageUserUsecase.execute(
        userId: post.userId,
        postId: post.postId,
        isGreen: isGreen,
      );
    } catch (e) {
      // ❌ HATA → GERİ AL
      emit(state.copyWith(redFlagCount: prevRed, greenFlagCount: prevGreen));
    }
  }

  Future<void> toggleFollow(String targetUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final currentlyFollowing = state.isFollowing;

    emit(state.copyWith(isFollowActionLoading: true));

    try {
      await followUserUsecase.execute(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
        isFollow: !currentlyFollowing,
      );

      emit(
        state.copyWith(
          isFollowActionLoading: false,
          isFollowing: !currentlyFollowing,
          followMessage: !currentlyFollowing
              ? "Kullanıcı takip edildi"
              : "Takipten çıkıldı",
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFollowActionLoading: false,
          errorMessage: "Takip işlemi başarısız oldu",
          followMessage: null,
        ),
      );
    }
  }
}
