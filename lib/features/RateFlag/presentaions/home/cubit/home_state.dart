import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/core/enum/request_status.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

enum HomeTab { map, forYou }

class HomeState extends Equatable {
  final RequestStatus loadPostsStatus;
  final RequestStatus ratePostStatus;

  final String? errorMessage;
  final List<Post> posts;
  final Set<Marker> markers;
  final HomeTab selectedTab;

  final String? openedImageUrl;
  final Post? openedPost;

  const HomeState({
    this.loadPostsStatus = RequestStatus.initial,
    this.ratePostStatus = RequestStatus.initial,
    this.errorMessage,
    this.posts = const [],
    this.markers = const {},
    this.selectedTab = HomeTab.forYou,
    this.openedImageUrl,
    this.openedPost,
  });

  HomeState copyWith({
    RequestStatus? loadPostsStatus,
    RequestStatus? ratePostStatus,
    String? errorMessage,
    List<Post>? posts,
    Set<Marker>? markers,
    HomeTab? selectedTab,
    String? openedImageUrl,
    Post? openedPost,
  }) {
    return HomeState(
      loadPostsStatus: loadPostsStatus ?? this.loadPostsStatus,
      ratePostStatus: ratePostStatus ?? this.ratePostStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
      markers: markers ?? this.markers,
      selectedTab: selectedTab ?? this.selectedTab,
      openedImageUrl: openedImageUrl ?? this.openedImageUrl,
      openedPost: openedPost ?? this.openedPost,
    );
  }

  @override
  List<Object?> get props => [
    loadPostsStatus,
    ratePostStatus,
    errorMessage,
    posts,
    markers,
    selectedTab,
    openedImageUrl,
    openedPost,
  ];
}
