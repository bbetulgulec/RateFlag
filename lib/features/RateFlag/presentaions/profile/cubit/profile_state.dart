import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

class ProfileState extends Equatable {
  final int tabIndex;
  final bool isPostLoading;
  final bool isPostSuccess;
  final String? errorMessage;
  final List<Post> posts;
  final int postCount;
  final List<String> followers;
  final List<String> following;
  final bool isFollowActionLoading;
  final bool isFollowActionSuccess;
  final bool isFollowing;

  final int followersCount;
  final int followingCount;

  final User? user;

  const ProfileState({
    this.tabIndex = 0,
    this.isPostLoading = false,
    this.isPostSuccess = false,
    this.errorMessage,
    this.posts = const [],
    this.postCount = 0,
    this.followers = const [],
    this.following = const [],
    this.isFollowActionLoading = false,
    this.isFollowActionSuccess = false,
    this.isFollowing = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.user,
  });

  ProfileState copyWith({
    int? tabIndex,
    bool? isPostLoading,
    bool? isPostSuccess,
    String? errorMessage,
    List<Post>? posts,
    int? postCount,
    List<String>? followers,
    List<String>? following,
    bool? isFollowActionLoading,
    bool? isFollowActionSuccess,
    bool? isFollowing,
    int? followersCount,
    int? followingCount,
    User? user,
  }) {
    return ProfileState(
      tabIndex: tabIndex ?? this.tabIndex,
      isPostLoading: isPostLoading ?? this.isPostLoading,
      isPostSuccess: isPostSuccess ?? this.isPostSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
      postCount: postCount ?? this.postCount,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowActionLoading:
          isFollowActionLoading ?? this.isFollowActionLoading,
      isFollowActionSuccess:
          isFollowActionSuccess ?? this.isFollowActionSuccess,
      isFollowing: isFollowing ?? this.isFollowing,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    tabIndex,
    isPostLoading,
    isPostSuccess,
    errorMessage,
    posts,
    postCount,
    followers,
    following,
    isFollowActionLoading,
    isFollowActionSuccess,
    isFollowing,
    followersCount,
    followingCount,
    user,
  ];
}
