abstract class FirestoreRepository {
  Future<void> createUser(String collection, Map<String, dynamic> data);
}
