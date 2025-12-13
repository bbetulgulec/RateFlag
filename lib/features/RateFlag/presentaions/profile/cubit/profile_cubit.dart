import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_post_user_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final LoadPostUserUsecase loadPostUserUsecase;

  ProfileCubit(this.loadPostUserUsecase) : super(const ProfileState());

  void changeTab(int index) {
    emit(state.copyWith(tabIndex: index));
  }

  Future<void> loadPosts() async {
    emit(
      state.copyWith(
        isPostLoading: true,
        isPostSuccess: false,
        errorMessage: null,
      ),
    );

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final posts = await loadPostUserUsecase.execute(userId);

      emit(
        state.copyWith(isPostLoading: false, isPostSuccess: true, posts: posts),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isPostLoading: false,
          isPostSuccess: false,
          errorMessage: "Hata oluştu: $e",
        ),
      );
    }
  }
}
