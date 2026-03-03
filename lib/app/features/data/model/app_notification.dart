import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  final String userId;
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  const AppNotification({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "body": body,
    "createdAt": createdAt.toIso8601String(),
  };

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  @override
  List<Object?> get props => [id, userId];
}
