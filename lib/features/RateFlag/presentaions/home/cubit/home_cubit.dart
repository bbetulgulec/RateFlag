import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/domain/usecase/load_all_post_user_usercase.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadAllPostsUsecase loadAllPostUserUsercase;
  final String currentUserId;

  HomeCubit(this.loadAllPostUserUsercase, this.currentUserId)
    : super(HomeState());

  Future<void> loadAllPosts() async {
    emit(state.copyWith(isAllPostLoading: true));

    try {
      final posts = await loadAllPostUserUsercase.execute();

      final Set<Marker> markers = {};

      for (final post in posts) {
        // 🔥 SADECE NORMAL MARKER (ŞİMDİLİK)
        markers.add(
          Marker(
            markerId: MarkerId(post.postId),
            position: LatLng(post.latitude, post.longitude),
            infoWindow: InfoWindow(title: post.city, snippet: post.description),
          ),
        );
      }

      emit(
        state.copyWith(
          isAllPostLoading: false,
          isAllPostSuccess: true,
          posts: posts,
          markers: markers,
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
}
