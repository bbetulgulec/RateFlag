abstract class FirestoreRepository {
  Future<void> createUser(String collection, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getUserInfo(String userID);
  Future<void> updateUserInfo(String userID, Map<String, dynamic> data);
}
