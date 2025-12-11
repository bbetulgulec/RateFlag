import 'dart:io';

import 'package:rate_flag/features/RateFlag/domain/repositories/storage_repository.dart';

class UploadImageStorageUserUsecase {
  StorageRepository storageRepository;

  UploadImageStorageUserUsecase(this.storageRepository);

  Future<String?> execute(File image, String postId) async {
    return await storageRepository.uploadImage(image, postId);
  }
}
