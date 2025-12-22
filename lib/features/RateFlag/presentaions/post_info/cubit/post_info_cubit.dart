import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/create_comment.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_Saved_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/is_following.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_post_by_id.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_post_comment.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_user_posts.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/toggle_follow.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/share_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/rate_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/toogle_saved_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/local/local_send_notification.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart' as myuser;

class PostInfoCubit extends Cubit<PostInfoState> {
  final LoadUserPosts loadPostUserUsecase;
  final LoadPostById loadPostById;
  final IsFollowing isFollowing;
  final RatePost rateTheImageUserUsecase;
  final RatePost followUserUsecase;
  final GetUserInfo getUserInfo;
  final CreateComment createComment;
  final PostShare postInfoShareUserUsecase;
  final ToggleFollows toggleFollow;
  final ToggleSavedPost toggleSavedPost;
  final GetSavedPosts getSavedPosts;
  final LoadPostComment loadPostComments;

  final LocalSendNotification localSendNotification;
  PostInfoCubit(
    this.loadPostUserUsecase,
    this.rateTheImageUserUsecase,
    this.followUserUsecase,
    this.postInfoShareUserUsecase,
    this.toggleFollow,
    this.loadPostById,
    this.isFollowing,
    this.getUserInfo,
    this.createComment,
    this.toggleSavedPost,
    this.localSendNotification,
    this.getSavedPosts,
    this.loadPostComments,
  ) : super(PostInfoState());

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> loadPostCommentsByPostId(String postId) async {
    if (isClosed) return;
    emit(state.copyWith(commentStatus: RequestStatus.loading));

    try {
      final comments = await loadPostComments.execute(postId: postId);
      if (isClosed) return;
      final Map<String, myuser.User> usersMap = {};

      for (final comment in comments) {
        if (!usersMap.containsKey(comment.userId)) {
          final user = await getUserInfo.execute(comment.userId);
          if (user != null) {
            usersMap[comment.userId] = user;
          }
        }
      }
      if (isClosed) return;
      emit(
        state.copyWith(
          commentStatus: RequestStatus.success,
          comments: comments,
          commentUsers: usersMap,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          commentStatus: RequestStatus.failure,
          errorMessage: TextConstants.didNotUploadComment,
        ),
      );
    }
  }

  Future<void> submitComment(String postId, String text) async {
    if (text.trim().isEmpty) return;

    final comment = Comment(
      commentId: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId,
      userId: currentUserId,
      content: text.trim(),
    );

    try {
      await createComment.execute(comment: comment);
      await loadPostCommentsByPostId(postId);

      final postOwner = state.user;
      final uid = currentUserId;

      if (postOwner != null) {
        await localSendNotification.call(
          userId: uid,
          title: TextConstants.uploasingPost,
          body:
              "${postOwner.firstName} ${postOwner.lastName}  ${TextConstants.sendCommentForUser}",
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          commentStatus: RequestStatus.failure,
          errorMessage: TextConstants.sendFailed,
        ),
      );
    }
  }

  Future<void> loadPostInfo({required String postId}) async {
    emit(
      state.copyWith(postInfoStatus: RequestStatus.loading, errorMessage: null),
    );

    try {
      // 1️ Postu çek
      final post = await loadPostById.execute(postId);

      if (post == null) {
        emit(
          state.copyWith(
            postInfoStatus: RequestStatus.failure,
            errorMessage: TextConstants.didNotPost,
          ),
        );
        return;
      }

      // 2️⃣ Kullanıcıyı çek
      final myuser.User? user = await getUserInfo.execute(post.userId);

      if (user == null) {
        emit(
          state.copyWith(
            postInfoStatus: RequestStatus.failure,
            errorMessage: TextConstants.doNotFoundPerson,
          ),
        );
        return;
      }

      // 3️⃣ Post + User state
      if (isClosed) return;
      emit(
        state.copyWith(
          postInfoStatus: RequestStatus.success,
          post: post,
          user: user,
          greenFlagCount: post.greenFlag,
          redFlagCount: post.redFlag,
          hasGreenFlag: post.flaggedBy?[currentUserId] == "green",
          hasRedFlag: post.flaggedBy?[currentUserId] == "red",
        ),
      );
      // 🔥 BURASI EKSİKTİ
      await loadPostCommentsByPostId(post.postId);

      // ✅ 4️⃣ KAYDEDİLME DURUMUNU BURADA YÜKLE
      await loadSavedStatus(post.postId);
    } catch (e) {
      emit(
        state.copyWith(
          postInfoStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> ratePost({required Post post, required bool isGreen}) async {
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

    await localSendNotification.call(
      userId: currentUserId,
      title: TextConstants.uploasingPost,
      body:
          "${TextConstants.onePost}${isGreen ? TextConstants.green : TextConstants.red} ${TextConstants.takeFlag}",
    );

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
          errorMessage: TextConstants.error,
        ),
      );
    }
  }

  Future<void> handleToggleFollow(String targetUserId) async {
    emit(state.copyWith(followStatus: RequestStatus.loading));

    try {
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
          followStatus: RequestStatus.success,
          isFollowing: updatedFollowing,
          followMessage: updatedFollowing
              ? TextConstants.followThePerson
              : TextConstants.followOutPerson,
          errorMessage: null,
          user: updatedUser,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          followStatus: RequestStatus.failure,
          errorMessage: TextConstants.followFailed,
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
        userName: "${user.firstName} ${user.lastName}",
        city: post.city,
        district: post.district,
        imageUrl: post.imageUrl,
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: TextConstants.failedPost));
    }
  }

  Future<myuser.User?> fetchCommentUser(String userId) async {
    return await getUserInfo.execute(userId);
  }

  Future<void> toggleSavePost(Post post) async {
    final userId = currentUserId;

    // ⚡ Anında UI
    emit(state.copyWith(isSaved: !state.isSaved));

    try {
      await toggleSavedPost.execute(userId: userId, postId: post.postId);
    } catch (e) {
      // ❌ hata olursa geri al
      emit(state.copyWith(isSaved: !state.isSaved));
    }
  }

  Future<void> loadSavedStatus(String postId) async {
    final userId = currentUserId;

    final savedPosts = await getSavedPosts.execute(userId: userId);

    emit(state.copyWith(isSaved: savedPosts.contains(postId)));
  }
}
