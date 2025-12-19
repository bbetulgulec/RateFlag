import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/add_comment_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/create_comment.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_follow_data.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/is_following.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_post_by_id.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_post_comments.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_user_posts.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/toggle_follow.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/share_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/rate_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/toogle_saved_post.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart' as MyUser;

class PostInfoCubit extends Cubit<PostInfoState> {
  final LoadUserPosts loadPostUserUsecase;
  final LoadPostById loadPostById;
  final IsFollowing isFollowing;
  final GetUserFollowData getUserFollowData;
  final RatePost rateTheImageUserUsecase;
  final RatePost followUserUsecase;
  final GetUserInfo getUserInfo;
  final CreateComment createComment;
  final PostShare postInfoShareUserUsecase;
  final ToggleFollows toggleFollow;
  final AddCommentPost addCommentPost;
  final LoadPostComments loadPostComments;
  final ToggleSavedPost toggleSavedPost;

  PostInfoCubit(
    this.loadPostUserUsecase,
    this.rateTheImageUserUsecase,
    this.followUserUsecase,
    this.postInfoShareUserUsecase,
    this.toggleFollow,
    this.loadPostById,
    this.getUserFollowData,
    this.isFollowing,
    this.getUserInfo,
    this.createComment,
    this.addCommentPost,
    this.loadPostComments,
    this.toggleSavedPost,
  ) : super(PostInfoState());

  Future<void> loadPostInfo({required String postId}) async {
    emit(state.copyWith(isLoadPostInfoLoading: true, errorMessage: null));

    try {
      // 1️⃣ Postu çek
      final post = await loadPostById.execute(postId);
      if (post == null) {
        emit(
          state.copyWith(
            isLoadPostInfoLoading: false,
            errorMessage: "Post bulunamadı",
          ),
        );
        return;
      }

      // 2️⃣ Kullanıcıyı çek
      final MyUser.User? user = await getUserInfo.execute(post.userId);

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

      // 3️⃣ State güncelle
      emit(
        state.copyWith(
          post: post,
          user: user,
          greenFlagCount: post.greenFlag,
          redFlagCount: post.redFlag,
          hasGreenFlag: post.flaggedBy?[currentUserId] == "green",
          hasRedFlag: post.flaggedBy?[currentUserId] == "red",
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

  Future<void> ratePost({required Post post, required bool isGreen}) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // UI için önceki değerler
    final prevGreen = state.greenFlagCount ?? post.greenFlag ?? 0;
    final prevRed = state.redFlagCount ?? post.redFlag ?? 0;
    final prevGreenFlag =
        state.hasGreenFlag ?? (post.flaggedBy?[currentUserId] == "green");
    final prevRedFlag =
        state.hasRedFlag ?? (post.flaggedBy?[currentUserId] == "red");

    int newGreen = prevGreen;
    int newRed = prevRed;

    // Oy durumunu güncelle
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

    // UI güncelle
    emit(
      state.copyWith(
        greenFlagCount: newGreen,
        redFlagCount: newRed,
        hasGreenFlag: isGreen,
        hasRedFlag: !isGreen,
      ),
    );

    try {
      // Firestore update
      await rateTheImageUserUsecase.execute(
        userId: currentUserId,
        post: post,
        isGreen: isGreen,
      );
    } catch (e) {
      // Hata → UI geri al
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

  Future<void> handleToggleFollow(String targetUserId) async {
    emit(state.copyWith(isFollowActionLoading: true));

    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Firestore’dan güncel durumu al
      final currentlyFollowing = await isFollowing.execute(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
      );

      // Toggle işlemini yap
      await toggleFollow.execute(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
        isFollow: !currentlyFollowing,
      );

      // İşlem sonrası tekrar güncel durumu al
      final updatedFollowing = await isFollowing.execute(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
      );

      final updatedUser = await getUserInfo.execute(currentUserId);

      emit(
        state.copyWith(
          isFollowActionLoading: false,
          isFollowing: updatedFollowing,
          followMessage: updatedFollowing
              ? "Kullanıcı takip edildi"
              : "Takipten çıkıldı",
          errorMessage: null,
          user: updatedUser,
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

  Future<void> loadFollowStatus(String targetUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final following = await isFollowing.execute(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
    );

    emit(state.copyWith(isFollowing: following));
  }

  Future<void> sharePost() async {
    final post = state.post;
    final user = state.user;
    if (post == null || user == null) return;

    try {
      await postInfoShareUserUsecase.execute(
        description: post.description,
        userName: "${user.firstName} ${user.lastName}",
        city: post.city,
        district: post.district,
        imageUrl: post.imageUrl,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: "Paylaşım başarısız oldu"));
    }
  }

  Future<void> addComment(Comment comment) async {
    emit(state.copyWith(isCommentLoading: true, errorMessage: null));

    try {
      // 1️⃣ Yorumu comments collection'a ekle
      await createComment.execute(comment: comment);

      // 2️⃣ Post içindeki commentId listesine ekle
      await addCommentPost.execute(
        postId: comment.postId,
        commentId: comment.commentId,
      );

      // 3️⃣ UI güncelle
      final updatedComments = List<Comment>.from(state.comments ?? [])
        ..add(comment);

      emit(state.copyWith(isCommentLoading: false, comments: updatedComments));
    } catch (e) {
      emit(
        state.copyWith(
          isCommentLoading: false,
          errorMessage: "Yorum eklenemedi: $e",
        ),
      );
    }
  }

  Future<MyUser.User?> fetchCommentUser(String userId) async {
    return await getUserInfo.execute(userId);
  }

  Future<void> loadPostComment(Post post) async {
    emit(state.copyWith(isCommentLoading: true));

    try {
      final comments = await loadPostComments.execute(
        commentIds: List<String>.from(post.comments ?? []),
      );

      emit(state.copyWith(isCommentLoading: false, comments: comments));
    } catch (e) {
      emit(state.copyWith(isCommentLoading: false));
    }
  }

  Future<void> toggleSavePost(Post post) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await toggleSavedPost.execute(userId: userId, postId: post.postId);

    final updatedUser = await getUserInfo.execute(userId);
    emit(state.copyWith(user: updatedUser));
  }
}
