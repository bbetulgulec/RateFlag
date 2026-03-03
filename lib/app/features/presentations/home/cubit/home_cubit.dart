import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/app/common/enum/request_status.dart';
import 'package:rate_flag/app/features/data/model/post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/load_all_post.dart';
import 'package:rate_flag/app/features/data/usecase/firestore/rate_post.dart';
import 'package:rate_flag/app/features/presentations/home/cubit/home_state.dart';
import 'package:rate_flag/app/features/presentations/home/widget/post_marker_widget.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadAllPost loadAllPostUserUsecase;
  final RatePost rateTheImageUserUsecase;

  Set<Marker> markers = {};

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

  Future<void> buildMarkers(BuildContext context, List posts) async {
    final futures = posts.where((p) => p.imageUrl != null).map((post) async {
      final widget = PostMarkerWidget(
        post: post,
        onTap: () {
          openPost(post);
        },
      );
      return widget.buildMarker();
    }).toList();

    final markers = await Future.wait(futures);
    emit(state.copyWith(markers: markers.toSet()));
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
