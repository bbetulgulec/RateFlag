import 'package:rate_flag/features/rate_flag/domain/model/comment.dart';
import 'package:rate_flag/features/rate_flag/domain/model/post.dart';
import 'package:rate_flag/features/rate_flag/domain/model/user.dart';

enum RequestStatus { initial, loading, success, failure }

class PostInfoState {
  final RequestStatus postInfoStatus;
  final RequestStatus followStatus;
  final RequestStatus commentStatus;

  final String? errorMessage;
  final Post? post;
  final User? user;

  final int? redFlagCount;
  final int? greenFlagCount;

  final bool isFollowing;
  final bool isSaved;

  final String? followMessage;
  final bool? hasGreenFlag;
  final bool? hasRedFlag;

  final List<Comment>? comments;
  final Map<String, User>? commentUsers;
  final String commentText;

  PostInfoState({
    this.postInfoStatus = RequestStatus.initial,
    this.followStatus = RequestStatus.initial,
    this.commentStatus = RequestStatus.initial,
    this.errorMessage,
    this.post,
    this.user,
    this.redFlagCount,
    this.greenFlagCount,
    this.isFollowing = false,
    this.isSaved = false,
    this.followMessage,
    this.hasGreenFlag,
    this.hasRedFlag,
    this.comments,
    this.commentUsers,
    this.commentText = '',
  });

  PostInfoState copyWith({
    RequestStatus? postInfoStatus,
    RequestStatus? followStatus,
    RequestStatus? commentStatus,
    String? errorMessage,
    Post? post,
    User? user,
    int? redFlagCount,
    int? greenFlagCount,
    bool? isFollowing,
    bool? isSaved,
    String? followMessage,
    bool? hasGreenFlag,
    bool? hasRedFlag,
    List<Comment>? comments,
    Map<String, User>? commentUsers,
    String? commentText,
  }) {
    return PostInfoState(
      postInfoStatus: postInfoStatus ?? this.postInfoStatus,
      followStatus: followStatus ?? this.followStatus,
      commentStatus: commentStatus ?? this.commentStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      post: post ?? this.post,
      user: user ?? this.user,
      redFlagCount: redFlagCount ?? this.redFlagCount,
      greenFlagCount: greenFlagCount ?? this.greenFlagCount,
      isFollowing: isFollowing ?? this.isFollowing,
      isSaved: isSaved ?? this.isSaved,
      followMessage: followMessage ?? this.followMessage,
      hasGreenFlag: hasGreenFlag ?? this.hasGreenFlag,
      hasRedFlag: hasRedFlag ?? this.hasRedFlag,
      comments: comments ?? this.comments,
      commentUsers: commentUsers ?? this.commentUsers,
      commentText: commentText ?? this.commentText,
    );
  }

  List<Object?> get props => [
    postInfoStatus,
    followStatus,
    commentStatus,
    user,
    post,
    greenFlagCount,
    redFlagCount,
    isFollowing,
    isSaved,
    followMessage,
    hasGreenFlag,
    hasRedFlag,
    comments,
    commentUsers,
    commentText,
  ];
}
