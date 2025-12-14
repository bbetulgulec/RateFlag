import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'post_info_state.dart';

class PostInfoCubit extends Cubit<PostInfoState> {
  final LoadPostUserUsecase loadPostUserUsecase;

  PostInfoCubit(this.loadPostUserUsecase) : super(PostInfoState());

  Future<void> loadPostInfo({
    required String userId,
    required String postId,
  }) async {
    emit(state.copyWith(isLoadPostInfoLoading: true, errorMessage: null));

    try {
      // 🔥 1. Post çek
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

      // 🔥 2. User çek
      final user = await loadPostUserUsecase.getUserInfo(post.userId);

      emit(
        state.copyWith(post: post, user: user, isLoadPostInfoLoading: false),
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
}
