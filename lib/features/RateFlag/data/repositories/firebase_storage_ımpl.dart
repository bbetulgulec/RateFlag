import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/storage_repository.dart';

class FirebaseStorageImpl extends StorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String?> uploadImage(File image, String postId) async {
    try {
      final ref = storage.ref('posts/$postId.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();

      print("UPLOAD IMAGE URL => $url");
      return url;
    } catch (e) {
      print("uploadImage ERROR: $e");
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
      print("uploadProfileImage ERROR: $e");
      return null;
    }
  }
}
