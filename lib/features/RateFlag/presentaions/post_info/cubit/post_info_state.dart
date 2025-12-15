import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class PostInfoState {
  final bool isLoadPostInfoLoading;
  final bool isLoadPostInfoSuccess;
  final String? errorMessage;
  final Post? post;
  final Map<String, dynamic>? user;

  final int? redFlagCount;
  final int? greenFlagCount;

  final bool isFollowActionLoading;
  final bool isFollowing;
  final bool isFollowActionSuccess;
  final String? followMessage;

  PostInfoState({
    this.isLoadPostInfoLoading = false,
    this.isLoadPostInfoSuccess = false,
    this.errorMessage,
    this.post,
    this.user,
    this.redFlagCount,
    this.greenFlagCount,
    this.isFollowActionLoading = false,
    this.isFollowing = false,
    this.isFollowActionSuccess = false,
    this.followMessage,
  });

  PostInfoState copyWith({
    bool? isLoadPostInfoLoading,
    bool? isLoadPostInfoSuccess,
    String? errorMessage,
    Post? post,
    Map<String, dynamic>? user,
    int? redFlagCount,
    int? greenFlagCount,
    bool? isFollowActionLoading,
    bool? isFollowing,
    bool? isFollowActionSuccess,
    String? followMessage,
  }) {
    return PostInfoState(
      isLoadPostInfoLoading:
          isLoadPostInfoLoading ?? this.isLoadPostInfoLoading,
      isLoadPostInfoSuccess:
          isLoadPostInfoSuccess ?? this.isLoadPostInfoSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      post: post ?? this.post,
      user: user ?? this.user,
      redFlagCount: redFlagCount ?? this.redFlagCount,
      greenFlagCount: greenFlagCount ?? this.greenFlagCount,
      isFollowActionLoading:
          isFollowActionLoading ?? this.isFollowActionLoading,
      isFollowing: isFollowing ?? this.isFollowing,
      isFollowActionSuccess:
          isFollowActionSuccess ?? this.isFollowActionSuccess,
      followMessage: followMessage ?? this.followMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoadPostInfoLoading,
    user,
    post,
    greenFlagCount,
    redFlagCount,
    isFollowActionLoading,
    isFollowing,
    isFollowActionSuccess,
    followMessage,
  ];
}
