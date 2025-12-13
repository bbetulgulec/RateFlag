import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class HomeState extends Equatable {
  final bool isAllPostLoading;
  final bool isAllPostSuccess;
  final String? errorMessage;
  final List<Post> posts;

  HomeState({
    this.isAllPostLoading = false,
    this.isAllPostSuccess = false,
    this.errorMessage,
    this.posts = const [],
  });
  HomeState copyWith({
    bool? isAllPostLoading,
    bool? isAllPostSuccess,
    String? errorMessage,
    List<Post>? posts,
  }) {
    return HomeState(
      isAllPostLoading: isAllPostLoading ?? this.isAllPostLoading,
      isAllPostSuccess: isAllPostSuccess ?? this.isAllPostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [
    isAllPostLoading,
    isAllPostSuccess,
    errorMessage,
    posts,
  ];
}
