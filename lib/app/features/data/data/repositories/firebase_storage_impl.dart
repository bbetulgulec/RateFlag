import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rate_flag/app/features/data/domain/repositories/storage_repository.dart';

class FirebaseStorageImpl extends StorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String?> uploadImage(File image, String postId) async {
    try {
      final ref = storage.ref('posts/$postId.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();

      debugPrint("UPLOAD IMAGE URL => $url");
      return url;
    } catch (e) {
      debugPrint("uploadImage ERROR: $e");
      return null;
    }
  }

  @override
  Future<String?> uploadProfileImage(File image, String userId) async {
    try {
      final ref = storage.ref('profile_images/$userId.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint("uploadProfileImage ERROR: $e");
      return null;
    }
  }
}
