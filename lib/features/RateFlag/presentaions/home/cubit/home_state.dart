import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

enum HomeTab { map, forYou }

class HomeState extends Equatable {
  final bool isAllPostLoading;
  final bool isAllPostSuccess;
  final String? errorMessage;
  final List<Post> posts;
  final Set<Marker> markers;
  final HomeTab selectedTab;
  final bool isRatePostLoading;
  final bool isRatePostSuccess;

  final String? openedImageUrl;
  final Post? openedPost;

  HomeState({
    this.isAllPostLoading = false,
    this.isAllPostSuccess = false,
    this.errorMessage,
    this.posts = const [],
    this.markers = const {},
    this.selectedTab = HomeTab.forYou,
    this.openedImageUrl,
    this.openedPost,
    this.isRatePostLoading = false,
    this.isRatePostSuccess = false,
  });
  HomeState copyWith({
    bool? isAllPostLoading,
    bool? isAllPostSuccess,
    String? errorMessage,
    List<Post>? posts,
    Set<Marker>? markers,
    HomeTab? selectedTab,
    String? openedImageUrl,
    bool? isRatePostLoading,
    bool? isRatePostSuccess,
    Post? openedPost,
  }) {
    return HomeState(
      isAllPostLoading: isAllPostLoading ?? this.isAllPostLoading,
      isAllPostSuccess: isAllPostSuccess ?? this.isAllPostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
      markers: markers ?? this.markers,
      selectedTab: selectedTab ?? this.selectedTab,
      openedImageUrl: openedImageUrl ?? this.openedImageUrl,
      isRatePostLoading: isRatePostLoading ?? this.isRatePostLoading,
      isRatePostSuccess: isRatePostSuccess ?? this.isRatePostSuccess,
      openedPost: openedPost ?? this.openedPost,
    );
  }

  @override
  List<Object?> get props => [
    isAllPostLoading,
    isAllPostSuccess,
    errorMessage,
    posts,
    markers,
    selectedTab,
    openedImageUrl,
    isRatePostLoading,
    isRatePostSuccess,
    openedPost,
  ];
}
