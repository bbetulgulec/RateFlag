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

  // 🔥 HARİTA İÇİN ZORUNLU
  final double latitude;
  final double longitude;

  const Post({
    required this.postId,
    required this.userId,
    required this.isPublic,
    required this.date,
    required this.city,
    required this.district,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    this.createdAt,
  });
}
