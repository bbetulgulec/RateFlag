import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';

class ProfileState extends Equatable {
  final int tabIndex;
  final bool isPostLoading;
  final String? errorMessage;

  final List<Post> publicPosts;
  final List<Post> savedPost;

  final List<String> followers;
  final List<String> following;

  final bool isFollowing;
  final int followersCount;
  final int followingCount;

  final User? user;
  final File? selectedImage;
  final bool isImageUploading;

  const ProfileState({
    this.tabIndex = 0,
    this.isPostLoading = false,
    this.errorMessage,
    this.publicPosts = const [],
    this.savedPost = const [],
    this.followers = const [],
    this.following = const [],
    this.isFollowing = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.user,
    this.selectedImage,
    this.isImageUploading = false,
  });

  int get postCount => publicPosts.length;

  ProfileState copyWith({
    int? tabIndex,
    bool? isPostLoading,
    String? errorMessage,
    List<Post>? publicPosts,
    List<Post>? savedPost,
    List<String>? followers,
    List<String>? following,
    bool? isFollowing,
    int? followersCount,
    int? followingCount,
    User? user,
    File? selectedImage,
    bool? isImageUploading,
  }) {
    return ProfileState(
      tabIndex: tabIndex ?? this.tabIndex,
      isPostLoading: isPostLoading ?? this.isPostLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      publicPosts: publicPosts ?? this.publicPosts,
      savedPost: savedPost ?? this.savedPost,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowing: isFollowing ?? this.isFollowing,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      user: user ?? this.user,
      selectedImage: selectedImage ?? this.selectedImage,
      isImageUploading: isImageUploading ?? this.isImageUploading,
    );
  }

  @override
  List<Object?> get props => [
    tabIndex,
    isPostLoading,
    errorMessage,
    publicPosts,
    savedPost,
    followers,
    following,
    isFollowing,
    followersCount,
    followingCount,
    user,
    selectedImage,
    isImageUploading,
  ];
}
