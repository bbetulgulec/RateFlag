class Post {
  final String postId;
  final String userId;
  final bool isPublic;
  final DateTime date;
  final String city;
  final String district;
  final String description;
  final String? imageUrl;
  final DateTime? createdAt;

  const Post({
    required this.postId,
    required this.userId,
    required this.isPublic,
    required this.date,
    required this.city,
    required this.district,
    required this.description,
    this.imageUrl,
    this.createdAt,
  });
}
