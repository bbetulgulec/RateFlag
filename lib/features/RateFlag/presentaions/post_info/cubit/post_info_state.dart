import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';

class PostInfoState {
  final bool isLoadPostInfoLoading;
  final bool isLoadPostInfoSuccess;
  final String? errorMessage;
  final Post? post;
  final Map<String, dynamic>? user; // User bilgisi Map olarak tutulacak

  PostInfoState({
    this.isLoadPostInfoLoading = false,
    this.isLoadPostInfoSuccess = false,
    this.errorMessage,
    this.post,
    this.user,
  });

  PostInfoState copyWith({
    bool? isLoadPostInfoLoading,
    bool? isLoadPostInfoSuccess,
    bool? isLoadUserInfoLoading,
    bool? isLoadUserInfoSuccess,
    String? errorMessage,
    Post? post,
    Map<String, dynamic>? user,
  }) {
    return PostInfoState(
      isLoadPostInfoLoading:
          isLoadPostInfoLoading ?? this.isLoadPostInfoLoading,
      isLoadPostInfoSuccess:
          isLoadPostInfoSuccess ?? this.isLoadPostInfoSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      post: post ?? this.post,
      user: user ?? this.user,
    );
  }
}
