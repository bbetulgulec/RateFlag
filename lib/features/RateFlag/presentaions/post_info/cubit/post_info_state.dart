import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart' as MyUser;

class PostInfoState {
  final bool isLoadPostInfoLoading;
  final bool isLoadPostInfoSuccess;
  final String? errorMessage;
  final Post? post;
  final User? user;

  final int? redFlagCount;
  final int? greenFlagCount;

  final bool isFollowActionLoading;
  final bool isFollowing;
  final bool isFollowActionSuccess;
  final String? followMessage;
  final bool? hasGreenFlag;
  final bool? hasRedFlag;

  final bool isCommentLoading;
  final bool isCommentSuccess;
  final List<Comment>? comments;
  final Map<String, MyUser.User>? commentUsers;

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
    this.hasGreenFlag,
    this.hasRedFlag,
    this.isCommentLoading = false,
    this.isCommentSuccess = false,
    this.comments,
    this.commentUsers,
  });

  PostInfoState copyWith({
    bool? isLoadPostInfoLoading,
    bool? isLoadPostInfoSuccess,
    String? errorMessage,
    Post? post,
    User? user,
    int? redFlagCount,
    int? greenFlagCount,
    bool? isFollowActionLoading,
    bool? isFollowing,
    bool? isFollowActionSuccess,
    String? followMessage,
    bool? hasGreenFlag,
    bool? hasRedFlag,
    bool? isCommentLoading,
    bool? isCommentSuccess,
    List<Comment>? comments,
    Map<String, MyUser.User>? commentUsers,
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
      hasGreenFlag: hasGreenFlag ?? this.hasGreenFlag,
      hasRedFlag: hasRedFlag ?? this.hasRedFlag,
      isCommentLoading: isCommentLoading ?? this.isCommentLoading,
      isCommentSuccess: isCommentSuccess ?? this.isCommentSuccess,
      comments: comments ?? this.comments,
      commentUsers: commentUsers ?? this.commentUsers,
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
    hasGreenFlag,
    hasRedFlag,
    isCommentLoading,
    isCommentSuccess,
    comments,
    commentUsers,
  ];
}
