import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/follow_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/post_info_share_user_usecase.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/rate_the_image_user_usecase.dart';
import 'post_info_state.dart';

class PostInfoCubit extends Cubit<PostInfoState> {
  final LoadPostUserUsecase loadPostUserUsecase;
  final RateTheImageUserUsecase rateTheImageUserUsecase;
  final FollowUserUsecase followUserUsecase;
  final PostInfoShareUserUsecase postInfoShareUserUsecase;

  PostInfoCubit(
    this.loadPostUserUsecase,
    this.rateTheImageUserUsecase,
    this.followUserUsecase,
    this.postInfoShareUserUsecase,
  ) : super(PostInfoState());

  Future<void> loadPostInfo({
    required String userId,
    required String postId,
  }) async {
    emit(state.copyWith(isLoadPostInfoLoading: true, errorMessage: null));

    try {
      // 1️⃣ Postu çek
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

      // 2️⃣ Kullanıcı bilgilerini çek
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

      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // 3️⃣ Kullanıcı takip durumunu kontrol et
      final bool following = await followUserUsecase.isFollowing(
        currentUserId: currentUserId,
        targetUserId: post.userId,
      );

      // 5️⃣ State emit et
      emit(
        state.copyWith(
          post: post,
          user: user,
          isFollowing: following,
          isLoadPostInfoLoading: false,
          greenFlagCount: post.greenFlag ?? 0,
          redFlagCount: post.redFlag ?? 0,
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
    required String postOwnerId,
    required String postId,
    required bool isGreen,
  }) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final prevRed = state.redFlagCount ?? 0;
    final prevGreen = state.greenFlagCount ?? 0;
    bool prevGreenFlag = state.hasGreenFlag ?? false;
    bool prevRedFlag = state.hasRedFlag ?? false;

    int newGreen = prevGreen;
    int newRed = prevRed;

    // Önceki oy durumuna göre güncelle
    if (prevGreenFlag && !isGreen) {
      newGreen--;
      newRed++;
    } else if (prevRedFlag && isGreen) {
      newRed--;
      newGreen++;
    } else if (!prevGreenFlag && !prevRedFlag) {
      if (isGreen)
        newGreen++;
      else
        newRed++;
    }

    // UI anında güncelle
    emit(
      state.copyWith(
        greenFlagCount: newGreen,
        redFlagCount: newRed,
        hasGreenFlag: isGreen,
        hasRedFlag: !isGreen,
      ),
    );

    try {
      await rateTheImageUserUsecase.execute(
        userId: currentUserId,
        postOwnerId: postOwnerId,
        postId: postId,
        isGreen: isGreen,
      );
    } catch (e) {
      // hata → geri al
      emit(
        state.copyWith(
          greenFlagCount: prevGreen,
          redFlagCount: prevRed,
          hasGreenFlag: prevGreenFlag,
          hasRedFlag: prevRedFlag,
          errorMessage: "Posta oy verilemedi",
        ),
      );
    }
  }

  Future<void> toggleFollow(String targetUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final currentlyFollowing = state.isFollowing ?? false;

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

  Future<void> sharePost() async {
    final post = state.post;
    final user = state.user;
    if (post == null || user == null) return;

    try {
      await postInfoShareUserUsecase.execute(
        description: post.description,
        userName: "${user['firstName']} ${user['lastName']}",
        city: post.city,
        district: post.district,
        imageUrl: post.imageUrl,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: "Paylaşım başarısız oldu"));
    }
  }
}
