import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String commentId;
  final String postId;
  final String content;
  final String userId;

  const Comment({
    required this.commentId,
    required this.postId,
    required this.content,
    required this.userId,
  });

  factory Comment.fromFirestore(Map<String, dynamic> data) {
    return Comment(
      commentId: data['commentId'] ?? '',
      postId: data['postId'] ?? '',
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'commentId': commentId,
      'postId': postId,
      'content': content,
      'userId': userId,
    };
  }

  Comment copyWith({
    String? commentId,
    String? postId,
    String? content,
    String? userId,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [commentId, postId, content, userId];
}
