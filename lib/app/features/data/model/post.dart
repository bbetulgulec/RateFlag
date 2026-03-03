import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String postId;
  final String userId;
  final bool isPublic;
  final DateTime date;
  final String city;
  final String district;
  final String description;
  final String? imageUrl;
  final DateTime? createdAt;
  final int? redFlag;
  final int? greenFlag;
  final double latitude;
  final double longitude;
  final Map<String, String>? flaggedBy;
  final List<String>? comments;

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
    this.redFlag,
    this.greenFlag,
    this.flaggedBy,
    this.comments,
  });

  /// 🔥 Firestore → Entity
  factory Post.fromFirestore(Map<String, dynamic> data) {
    return Post(
      postId: data['postId'] ?? '',
      userId: data['userId'] ?? '',
      isPublic: data['isPublic'] ?? true,

      date: data['date'] is String
          ? DateTime.tryParse(data['date']) ?? DateTime.now()
          : DateTime.now(),

      city: data['city'] ?? '',
      district: data['district'] ?? '',
      description: data['description'] ?? '',

      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,

      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      redFlag: (data['redFlag'] as num?)?.toInt(),
      greenFlag: (data['greenFlag'] as num?)?.toInt(),
      flaggedBy: Map<String, String>.from(data['flaggedBy'] ?? {}),
      comments: (data['comments'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  /// 🔁 Entity → Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'postId': postId,
      'userId': userId,
      'isPublic': isPublic,
      'date': date.toIso8601String(),
      'city': city,
      'district': district,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'redFlag': redFlag ?? 0,
      'greenFlag': greenFlag ?? 0,
      'flaggedBy': flaggedBy ?? {},
      'comments': comments ?? [],
    };
  }

  /// 🔄 Copy
  Post copyWith({
    String? postId,
    String? userId,
    bool? isPublic,
    DateTime? date,
    String? city,
    String? district,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    int? redFlag,
    int? greenFlag,
    double? latitude,
    double? longitude,
    Map<String, String>? flaggedBy,
    List<String>? comments,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      isPublic: isPublic ?? this.isPublic,
      date: date ?? this.date,
      city: city ?? this.city,
      district: district ?? this.district,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      redFlag: redFlag ?? this.redFlag,
      greenFlag: greenFlag ?? this.greenFlag,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      flaggedBy: flaggedBy ?? this.flaggedBy,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [
    postId,
    userId,
    isPublic,
    date,
    city,
    district,
    description,
    imageUrl,
    createdAt,
    redFlag,
    greenFlag,
    latitude,
    longitude,
    flaggedBy,
    comments,
  ];
}
