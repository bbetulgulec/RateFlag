import 'dart:io';

import 'package:rate_flag/app/features/data/domain/repositories/storage_repository.dart';


class UploadProfileImage {
  final StorageRepository storageRepository;

  UploadProfileImage(this.storageRepository);

  Future<String?> execute({required File image, required String uid}) async {
    return await storageRepository.uploadProfileImage(image, uid);
  }
}
