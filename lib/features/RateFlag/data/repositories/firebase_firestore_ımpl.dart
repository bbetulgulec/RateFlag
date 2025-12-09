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
}
