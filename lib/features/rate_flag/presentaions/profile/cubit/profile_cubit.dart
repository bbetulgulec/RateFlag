import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rate_flag/features/rate_flag/domain/repositories/firestore_repository.dart';
import 'package:rate_flag/features/rate_flag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/rate_flag/domain/usecase/firestore/load_user_posts.dart';
import 'package:rate_flag/features/rate_flag/domain/usecase/firestore/update_user_info.dart';
import 'package:rate_flag/features/rate_flag/domain/usecase/storage/upload_profile_image.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserInfo getUserInfo;
  final UpdateUserInfo updateUserInfo;
  final UploadProfileImage uploadProfileImage;
  final LoadUserPosts loadUserPosts;
  final FirestoreRepository firestoreRepository;
  ProfileCubit(
    this.getUserInfo,
    this.updateUserInfo,
    this.uploadProfileImage,
    this.loadUserPosts,
    this.firestoreRepository,
  ) : super(const ProfileState()) {
    _loadInitial();
  }

  final ImagePicker picker = ImagePicker();

  void _loadInitial() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      loadUser(uid);
      loadAllPosts(uid);
    }
  }

  Future<void> loadUser(String uid) async {
    final user = await getUserInfo.execute(uid);
    if (user == null) return;

    final followersList = (user.followers ?? [])
        .map((e) => e.toString())
        .toList();
    final followingList = (user.following ?? [])
        .map((e) => e.toString())
        .toList();

    emit(
      state.copyWith(
        user: user,
        followers: followersList,
        following: followingList,
        followersCount: followersList.length,
        followingCount: followingList.length,
      ),
    );
  }

  Future<void> loadAllPosts(String uid) async {
    emit(state.copyWith(isPostLoading: true));

    final publicPosts = await loadUserPosts.execute(uid);

    emit(state.copyWith(publicPosts: publicPosts, isPostLoading: false));
  }

  Future<void> loadSavedPosts() async {
    final user = state.user;
    if (user == null) return;

    emit(state.copyWith(isPostLoading: true));

    final List<String> savedIds = user.postSaved ?? [];

    if (savedIds.isEmpty) {
      emit(state.copyWith(savedPost: [], isPostLoading: false));
      return;
    }

    final posts = await firestoreRepository.getSavedPostsByIds(savedIds);

    emit(state.copyWith(savedPost: posts, isPostLoading: false));
  }

  Future<void> pickFromGallery() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null) {
      final file = File(picked.path);
      emit(state.copyWith(selectedImage: file));
      _uploadProfilePhoto(file);
    }
  }

  Future<void> pickFromCamera() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (picked != null) {
      final file = File(picked.path);
      emit(state.copyWith(selectedImage: file));
      await _uploadProfilePhoto(file);
    }
  }

  Future<void> _uploadProfilePhoto(File file) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      // 1️⃣ Storage
      final imageUrl = await uploadProfileImage.execute(image: file, uid: uid);

      if (imageUrl == null) return;

      // 2️⃣ Mevcut user
      final currentUser = state.user;
      if (currentUser == null) return;

      // 3️⃣ User copy
      final updatedUser = currentUser.copyWith(photoUrl: imageUrl);

      // 4️⃣ Firestore (USER OLARAK)
      await updateUserInfo.execute(updatedUser);

      // 5️⃣ State
      emit(state.copyWith(user: updatedUser));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void changeTab(int index) {
    emit(state.copyWith(tabIndex: index));

    if (index == 1) {
      loadSavedPosts();
    }
  }
}
