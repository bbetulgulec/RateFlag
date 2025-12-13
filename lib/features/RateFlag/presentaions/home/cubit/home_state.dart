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

  HomeState({
    this.isAllPostLoading = false,
    this.isAllPostSuccess = false,
    this.errorMessage,
    this.posts = const [],
    this.markers = const {},
    this.selectedTab = HomeTab.forYou,
  });
  HomeState copyWith({
    bool? isAllPostLoading,
    bool? isAllPostSuccess,
    String? errorMessage,
    List<Post>? posts,
    Set<Marker>? markers,
    HomeTab? selectedTab,
  }) {
    return HomeState(
      isAllPostLoading: isAllPostLoading ?? this.isAllPostLoading,
      isAllPostSuccess: isAllPostSuccess ?? this.isAllPostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
      markers: markers ?? this.markers,
      selectedTab: selectedTab ?? this.selectedTab,
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
  ];
}
