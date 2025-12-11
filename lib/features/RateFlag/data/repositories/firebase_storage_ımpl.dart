import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/storage_repository.dart';

class FirebaseStorageImpl extends StorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File image, String postId) async {
    try {
      // Reference oluştur
      final ref = storage.ref().child('posts').child('$postId.jpg');

      // Resmi yükle
      await ref.putFile(image);

      // URL al
      final url = await ref.getDownloadURL();
      return url; // Firestore'a kaydedilecek URL
    } catch (e) {
      print("uploadImage ERROR: $e");
      return null;
    }
  }
}
