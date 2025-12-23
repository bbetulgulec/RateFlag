import 'dart:io';

import 'package:rate_flag/features/RateFlag/domain/repositories/storage_repository.dart';

class UploadImageStorage {
  final StorageRepository repository;

  UploadImageStorage(this.repository);

  Future<String?> execute(File image, String postId) {
    return repository.uploadImage(image, postId);
  }
}
