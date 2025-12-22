import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/core/enum/request_status.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/rate_post.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadAllPost loadAllPostUserUsecase;
  final RatePost rateTheImageUserUsecase;

  HomeCubit(this.loadAllPostUserUsecase, this.rateTheImageUserUsecase)
    : super(const HomeState());

  Future<void> loadAllPosts() async {
    emit(state.copyWith(loadPostsStatus: RequestStatus.loading));

    try {
      final posts = await loadAllPostUserUsecase.execute();

      posts.sort((a, b) {
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });

      emit(
        state.copyWith(loadPostsStatus: RequestStatus.success, posts: posts),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadPostsStatus: RequestStatus.failure,
          errorMessage: "Postlar yüklenemedi",
        ),
      );
    }
  }

  void selectMap() {
    emit(state.copyWith(selectedTab: HomeTab.map));
  }

  void selectForYou() {
    emit(state.copyWith(selectedTab: HomeTab.forYou));
  }

  void openPost(Post? post) {
    emit(state.copyWith(openedPost: post));
  }
}
