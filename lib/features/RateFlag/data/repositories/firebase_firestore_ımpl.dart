import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class FirebaseFirestoreImpl implements FirestoreRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
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
  Future<void> createPost(String collection, Post post) async {
    try {
      // users/{userId}/posts/{postId}
      await firestore
          .collection("users")
          .doc(post.userId)
          .collection("posts")
          .doc(post.postId)
          .set({
            "postId": post.postId,
            "userId": post.userId,
            "description": post.description,
            "imageUrl": post.imageUrl,
            "isPublic": post.isPublic,
            "date": post.date.toIso8601String(),
            "city": post.city,
            "district": post.district,
            "createdAt": FieldValue.serverTimestamp(),
            "latitude": post.latitude,
            "longitude": post.longitude,
          });

      print("Post saved successfully under user: ${post.userId}");
    } catch (e) {
      print("createPost ERROR: $e");
      rethrow;
    }
  }

  @override
  Future<List<Post>> loadAllPosts() async {
    final snapshot = await firestore.collectionGroup('posts').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Post(
        postId: data['postId'],
        userId: data['userId'],
        description: data['description'],
        imageUrl: data['imageUrl'],
        isPublic: data['isPublic'],
        city: data['city'],
        district: data['district'],
        date: DateTime.parse(data['date']),
        latitude: (data['latitude'] as num).toDouble(),
        longitude: (data['longitude'] as num).toDouble(),
        createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
        redFlag: (data['redFlag'] as num?)?.toInt() ?? 0, // Flagging part
        greenFlag: (data['greenFlag'] as num?)?.toInt() ?? 0, // Flagging part
      );
    }).toList();
  }

  @override
  Future<List<Post>> loadUserPosts(String userId) async {
    try {
      final query = await firestore
          .collection("users")
          .doc(userId)
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .get();

      // QuerySnapshot → List<Post>
      return query.docs.map((doc) {
        final data = doc.data();
        return Post(
          postId: data["postId"],
          userId: data["userId"],
          description: data["description"],
          imageUrl: data["imageUrl"],
          isPublic: data["isPublic"],
          date: DateTime.parse(data["date"]),
          city: data["city"],
          district: data["district"],
          latitude: (data['latitude'] as num).toDouble(),
          longitude: (data['longitude'] as num).toDouble(),
          createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
          redFlag: (data['redFlag'] as num?)?.toInt() ?? 0, // Flagging part
          greenFlag: (data['greenFlag'] as num?)?.toInt() ?? 0, // Flagging part
          // Flagging part
        );
      }).toList();
    } catch (e) {
      print("loadUserPosts ERROR: $e");
      return [];
    }
  }

  @override
  Future<void> incrementFlag({
    required String userId,
    required String postOwnerId,
    required String postId,
    required bool isGreen,
  }) async {
    final postRef = firestore
        .collection('users')
        .doc(postOwnerId)
        .collection('posts')
        .doc(postId);

    await firestore.runTransaction((transaction) async {
      final postSnap = await transaction.get(postRef);
      final data = postSnap.data()!;
      // Map olarak flaggedBy al
      final Map<String, dynamic> flaggedBy = Map<String, dynamic>.from(
        data['flaggedBy'] ?? {},
      );

      final previousVote = flaggedBy[userId]; // null, "green" veya "red"

      // Eğer önceki oy aynı ise return
      if ((isGreen && previousVote == "green") ||
          (!isGreen && previousVote == "red")) {
        print("User already voted the same");
        return;
      }
      // Oy değişikliği yap
      if (previousVote == "green") {
        transaction.update(postRef, {'greenFlag': FieldValue.increment(-1)});
      } else if (previousVote == "red") {
        transaction.update(postRef, {'redFlag': FieldValue.increment(-1)});
      }

      // Yeni oy ekle
      transaction.update(postRef, {
        isGreen ? 'greenFlag' : 'redFlag': FieldValue.increment(1),
        'flaggedBy': {...flaggedBy, userId: isGreen ? "green" : "red"},
      });

      print("Firestore vote updated successfully");
    });
  }

  @override
  Future<Post?> getPostById(String userId, String postId) async {
    final doc = await firestore
        .collection('users')
        .doc(userId)
        .collection('posts')
        .doc(postId)
        .get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    return Post(
      postId: data['postId'],
      userId: data['userId'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      isPublic: data['isPublic'],
      date: DateTime.parse(data['date']),
      city: data['city'],
      district: data['district'],
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      redFlag: (data['redFlag'] as num?)?.toInt() ?? 0,
      greenFlag: (data['greenFlag'] as num?)?.toInt() ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  @override
  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final currentUserRef = firestore.collection('users').doc(currentUserId);
    final targetUserRef = firestore.collection('users').doc(targetUserId);

    await firestore.runTransaction((transaction) async {
      final currentSnap = await transaction.get(currentUserRef);
      final targetSnap = await transaction.get(targetUserRef);

      // Eğer alan yoksa boş liste ata
      final currentFollowing = List<String>.from(
        currentSnap.data()?['following'] ?? [],
      );
      final targetFollowers = List<String>.from(
        targetSnap.data()?['followers'] ?? [],
      );

      if (!currentFollowing.contains(targetUserId)) {
        currentFollowing.add(targetUserId);
      }

      if (!targetFollowers.contains(currentUserId)) {
        targetFollowers.add(currentUserId);
      }

      transaction.update(currentUserRef, {'following': currentFollowing});
      transaction.update(targetUserRef, {'followers': targetFollowers});
    });
  }

  @override
  Future<void> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final currentUserRef = firestore.collection('users').doc(currentUserId);
    final targetUserRef = firestore.collection('users').doc(targetUserId);

    await firestore.runTransaction((transaction) async {
      final currentSnap = await transaction.get(currentUserRef);
      final targetSnap = await transaction.get(targetUserRef);

      final currentFollowing = List<String>.from(
        currentSnap.data()?['following'] ?? [],
      );
      final targetFollowers = List<String>.from(
        targetSnap.data()?['followers'] ?? [],
      );

      currentFollowing.remove(targetUserId);
      targetFollowers.remove(currentUserId);

      transaction.update(currentUserRef, {'following': currentFollowing});
      transaction.update(targetUserRef, {'followers': targetFollowers});
    });
  }
}
