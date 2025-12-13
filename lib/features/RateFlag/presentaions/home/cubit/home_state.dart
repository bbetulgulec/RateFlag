import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class HomeState extends Equatable {
  final bool isAllPostLoading;
  final bool isAllPostSuccess;
  final String? errorMessage;
  final List<Post> posts;
  final Set<Marker> markers;

  HomeState({
    this.isAllPostLoading = false,
    this.isAllPostSuccess = false,
    this.errorMessage,
    this.posts = const [],
    this.markers = const {},
  });
  HomeState copyWith({
    bool? isAllPostLoading,
    bool? isAllPostSuccess,
    String? errorMessage,
    List<Post>? posts,
    Set<Marker>? markers,
  }) {
    return HomeState(
      isAllPostLoading: isAllPostLoading ?? this.isAllPostLoading,
      isAllPostSuccess: isAllPostSuccess ?? this.isAllPostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [
    isAllPostLoading,
    isAllPostSuccess,
    errorMessage,
    posts,
    markers,
  ];
}
