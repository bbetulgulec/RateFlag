import 'package:equatable/equatable.dart';

enum Gender { male, female }

class User extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String mail;
  final DateTime birthDate;
  final String password;
  final Gender gender;
  final String? photoUrl;
  final List? followers;
  final List? following;
  final List<String>? postSaved;

  const User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.mail,
    required this.birthDate,
    required this.password,
    required this.gender,
    this.photoUrl,
    this.followers,
    this.following,
    this.postSaved,
  });

  /// Firestore → Model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['userID'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mail: json['mail'] ?? '',
      birthDate: json['birthDate'] is String
          ? DateTime.tryParse(json['birthDate']) ?? DateTime.now()
          : DateTime.now(),
      password: '',
      gender: Gender.values.firstWhere(
        (e) => e.name == json['gender'],
        orElse: () => Gender.male,
      ),
      photoUrl: json['photoUrl'],
      followers: json['followers'],
      following: json['following'],
      postSaved: (json['postSaved'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'userID': uid,
      'firstName': firstName,
      'lastName': lastName,
      'mail': mail,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender.name,
      'photoUrl': photoUrl,
      'followers': followers,
      'following': following,
      'postSaved': postSaved,
    };
  }

  User copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? mail,
    DateTime? birthDate,
    String? password,
    Gender? gender,
    String? photoUrl,
    List? followers,
    List? following,
    List<String>? postSaved,
  }) {
    return User(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mail: mail ?? this.mail,
      birthDate: birthDate ?? this.birthDate,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      photoUrl: photoUrl ?? this.photoUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      postSaved: postSaved ?? this.postSaved,
    );
  }

  @override
  List<Object?> get props => [
    uid,
    firstName,
    lastName,
    mail,
    birthDate,
    gender,
    password,
    photoUrl,
    followers,
    following,
    postSaved,
  ];
}
