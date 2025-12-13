import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class ProfileState extends Equatable {
  final int tabIndex;
  final bool isPostLoading;
  final bool isPostSuccess;
  final String? errorMessage;
  final List<Post> posts;

  const ProfileState({
    this.tabIndex = 0,
    this.isPostLoading = false,
    this.isPostSuccess = false,
    this.errorMessage,
    this.posts = const [],
  });

  ProfileState copyWith({
    int? tabIndex,
    bool? isPostLoading,
    bool? isPostSuccess,
    String? errorMessage,
    List<Post>? posts,
  }) {
    return ProfileState(
      tabIndex: tabIndex ?? this.tabIndex,
      isPostLoading: isPostLoading ?? this.isPostLoading,
      isPostSuccess: isPostSuccess ?? this.isPostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [
    tabIndex,
    isPostLoading,
    isPostSuccess,
    errorMessage,
  ];
}
