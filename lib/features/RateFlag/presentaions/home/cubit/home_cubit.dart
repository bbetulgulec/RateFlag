import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/rate_post.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadAllPost loadAllPostUserUsercase;
  final RatePost rateTheImageUserUsecase;

  HomeCubit(this.loadAllPostUserUsercase, this.rateTheImageUserUsecase)
    : super(HomeState());

  Future<void> loadAllPosts() async {
    emit(state.copyWith(isAllPostLoading: true));

    try {
      final posts = await loadAllPostUserUsercase.execute();

      posts.sort((a, b) {
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });

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
  /*
  void openImage(String imageUrl) {
    emit(state.copyWith(openedImageUrl: imageUrl));
  }


  void closeImage() {
    emit(state.copyWith(openedImageUrl: null));
  } 
  void addPost(Post post) {
    final updatedPosts = [post, ...state.posts];
    emit(state.copyWith(posts: updatedPosts));
  }
   */

  void openPost(Post? post) {
    emit(state.copyWith(openedPost: post));
  }
}
