import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class FirebaseFirestoreImpl implements FirestoreRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(String collection, Map<String, dynamic> data) async {
    final userID = data["userID"];

    if (userID != null && collection == "users") {
      await firestore.collection(collection).doc(userID).set({
        ...data,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserInfo(String userID) async {
    try {
      final doc = await firestore.collection("users").doc(userID).get();

      if (doc.exists) {
        return doc.data();
      } else {
        return null;
      }
    } catch (e) {
      print("getUserInfo ERROR: $e");
      return null;
    }
  }

  @override
  Future<void> updateUserInfo(String userID, Map<String, dynamic> data) async {
    try {
      await firestore.collection("users").doc(userID).update(data);
    } catch (e) {
      print("updateUserInfo ERROR: $e");
    }
  }

  @override
  Future<void> deleteAccount(String userID) async {
    try {
      final doc = await firestore
          .collection("users")
          .doc(userID)
          .delete()
          .then(
            (doc) => print("documented deleted"),
            onError: (e) => print("error updating $e"),
          );
    } catch (e) {
      print(e);
    }
  }
}
