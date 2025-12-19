import 'dart:io';

abstract class StorageRepository {
  Future<String?> uploadImage(File image, String postId);
  Future<String?> uploadProfileImage(File image, String userId);
}
