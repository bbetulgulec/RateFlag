import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
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

  @override
  Future<void> createPost(
    String collection,
    Map<String, dynamic> data,
    Post post,
  ) async {
    try {
      await firestore.collection(collection).doc(post.postId).set({
        "postId": post.postId,
        "userId": post.userId,
        "description": post.description,
        "imageUrl": post.imageUrl,
        "isPublic": post.isPublic,
        "date": post.date.toIso8601String(),
        "city": post.city,
        "district": post.district,
        "createdAt": FieldValue.serverTimestamp(),
      });
      print("Post saved successfully: ${post.postId}");
    } catch (e) {
      print("createPost ERROR: $e");
      rethrow; // hatayı Cubit'e fırlat
    }
  }
}
