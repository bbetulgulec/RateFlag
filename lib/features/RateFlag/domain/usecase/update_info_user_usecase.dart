import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class UpdateInfoUserUsecase {
  final FirestoreRepository firestoreRepository;

  UpdateInfoUserUsecase(this.firestoreRepository);

  /// USER INFO GETİR
  Future<Map<String, dynamic>?> fetchUser(String userID) async {
    return await firestoreRepository.getUserInfo(userID);
  }

  /// USER INFO GÜNCELLE
  Future<void> updateUser(
    String userID,
    Map<String, dynamic> updatedData,
  ) async {
    await firestoreRepository.updateUserInfo(userID, updatedData);
  }
}
