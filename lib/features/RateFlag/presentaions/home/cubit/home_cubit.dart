import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_all_post_user_usercase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadAllPostsUsecase loadAllPostUserUsercase;
  final String currentUserId; // 🔥

  HomeCubit(this.loadAllPostUserUsercase, this.currentUserId)
    : super(HomeState());

  Future<void> loadAllPosts() async {
    emit(state.copyWith(isAllPostLoading: true, errorMessage: null));

    try {
      final posts = await loadAllPostUserUsercase.execute();

      emit(
        state.copyWith(
          isAllPostLoading: false,
          isAllPostSuccess: true,
          posts: posts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isAllPostLoading: false,
          isAllPostSuccess: false,
          errorMessage: "Bütün postlar yüklenirken hata oluştu",
        ),
      );
    }
  }
}
