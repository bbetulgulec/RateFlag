import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart';
import 'package:rate_flag/features/RateFlag/domain/repositories/firestore_repository.dart';

class FirebaseFirestoreImpl implements FirestoreRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUser(String collection, User user) async {
    try {
      await firestore.collection(collection).doc(user.uid).set({
        "userID": user.uid,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "mail": user.mail,
        "gender": user.gender.name,
        "birthDate": user.birthDate.toIso8601String(),
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("🔥 FIRESTORE CREATE USER ERROR: $e");
      rethrow;
    }
  }

  @override
  Future<User?> getUserInfo(String userID) async {
    try {
      final doc = await firestore.collection("users").doc(userID).get();

      if (!doc.exists || doc.data() == null) return null;

      return User.fromJson(doc.data()!);
    } catch (e) {
      print("getUserInfo ERROR: $e");
      return null;
    }
  }

  @override
  Future<List<User>> searchUserByFirstName(String name) async {
    final query = await firestore
        .collection("users")
        .where("firstName", isGreaterThanOrEqualTo: name)
        .where("firstName", isLessThanOrEqualTo: "$name\uf8ff")
        .get();

    return query.docs.map((e) => User.fromJson(e.data())).toList();
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      await firestore.collection("users").doc(user.uid).update(user.toJson());
    } catch (e) {
      print("updateUser ERROR: $e");
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
  Future<void> createPost(Post post) async {
    try {
      await firestore.collection("posts").doc(post.postId).set({
        ...post.toFirestore(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      print("Post saved successfully");
    } catch (e) {
      print("createPost ERROR: $e");
      rethrow;
    }
  }

  @override
  Future<void> createComment(Comment comment) async {
    try {
      final commentRef = firestore
          .collection("comments")
          .doc(comment.commentId);

      final postRef = firestore.collection("posts").doc(comment.postId);

      await firestore.runTransaction((transaction) async {
        /// 1️⃣ Yorumu oluştur
        transaction.set(commentRef, {
          ...comment.toFirestore(),
          "createdAt": FieldValue.serverTimestamp(),
        });

        /// 2️⃣ Post içindeki commentIds listesine ekle
        transaction.update(postRef, {
          "comments": FieldValue.arrayUnion([comment.commentId]),
        });
      });
    } catch (e) {
      print("Create comment error: $e");
    }
  }

  @override
  Future<void> toggleSavedPost({
    required String userId,
    required String postId,
  }) async {
    final userRef = firestore.collection("users").doc(userId);

    await firestore.runTransaction((transaction) async {
      final snap = await transaction.get(userRef);

      if (!snap.exists) {
        throw Exception("User not found");
      }

      final data = snap.data()!;
      final List<String> savedPosts = List<String>.from(
        data['postSaved'] ?? [],
      );

      if (savedPosts.contains(postId)) {
        // ❌ Kayıttan çıkar
        savedPosts.remove(postId);
      } else {
        // ✅ Kaydet
        savedPosts.add(postId);
      }

      transaction.update(userRef, {'postSaved': savedPosts});
    });
  }

  @override
  Future<void> addCommentIdToPost({
    required String postId,
    required String commentId,
  }) async {
    await firestore.collection("posts").doc(postId).update({
      "comments": FieldValue.arrayUnion([commentId]),
    });
  }

  @override
  Future<List<String>> getSavedPosts({required String userId}) async {
    final snap = await firestore.collection("users").doc(userId).get();

    if (!snap.exists) return [];

    return List<String>.from(snap.data()?['postSaved'] ?? []);
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final snapshot = await firestore
        .collection("comments")
        .where("postId", isEqualTo: postId)
        .get();

    return snapshot.docs
        .map((doc) => Comment.fromFirestore(doc.data()))
        .toList();
  }

  @override
  Future<List<Post>> loadAllPosts() async {
    final snapshot = await firestore
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .get();

    return snapshot.docs.map((doc) => Post.fromFirestore(doc.data())).toList();
  }

  @override
  Future<List<Post>> loadUserPosts(String userId) async {
    final query = await firestore
        .collection("posts")
        .where("userId", isEqualTo: userId)
        .orderBy("createdAt", descending: true)
        .get();

    print("POST COUNT: ${query.docs.length}");

    return query.docs.map((doc) => Post.fromFirestore(doc.data())).toList();
  }

  @override
  Future<List<Post>> loadUserPrivatePosts(String userId) async {
    final snap = await firestore
        .collection("posts")
        .where("userId", isEqualTo: userId)
        .where("isPublic", isEqualTo: false)
        .orderBy("createdAt", descending: true)
        .get();

    return snap.docs.map((d) => Post.fromFirestore(d.data())).toList();
  }

  @override
  Future<void> incrementFlag({
    required String userId,
    required String postOwnerId,
    required Post post, // artık Post modelini parametre olarak alıyoruz
    required bool isGreen,
  }) async {
    final postRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(post.postId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final postSnap = await transaction.get(postRef);
      final currentData = postSnap.data()!;
      final currentPost = Post.fromFirestore(currentData);

      // Map olarak flaggedBy al
      final Map<String, String> flaggedBy = Map<String, String>.from(
        currentPost.flaggedBy ?? {},
      );

      final previousVote = flaggedBy[userId]; // null, "green" veya "red"

      // Eğer önceki oy aynı ise return
      if ((isGreen && previousVote == "green") ||
          (!isGreen && previousVote == "red")) {
        print("User already voted the same");
        return;
      }

      // Oy değişikliği yap
      int greenCount = currentPost.greenFlag ?? 0;
      int redCount = currentPost.redFlag ?? 0;

      if (previousVote == "green") {
        greenCount--;
      } else if (previousVote == "red") {
        redCount--;
      }

      if (isGreen) {
        greenCount++;
      } else {
        redCount++;
      }

      // Yeni oy ve flaggedBy map’ini güncelle
      final updatedFlaggedBy = {
        ...flaggedBy,
        userId: isGreen ? "green" : "red",
      };

      // Firestore güncelle
      transaction.update(postRef, {
        'greenFlag': greenCount,
        'redFlag': redCount,
        'flaggedBy': updatedFlaggedBy,
      });

      print("Firestore vote updated successfully");
    });
  }

  @override
  Future<Post?> getPostById(String postId) async {
    final doc = await firestore.collection('posts').doc(postId).get();
    if (!doc.exists || doc.data() == null) return null;
    return Post.fromFirestore(doc.data()!);
  }

  @override
  Future<User?> getUserById(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    return User.fromJson(doc.data()!);
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

      // Mevcut user modellerini oluştur
      final currentUser = currentSnap.exists
          ? User.fromJson(currentSnap.data()!)
          : throw Exception("Current user not found");

      final targetUser = targetSnap.exists
          ? User.fromJson(targetSnap.data()!)
          : throw Exception("Target user not found");

      // Followers & following listelerini güncelle
      final updatedFollowing = List<String>.from(currentUser.following ?? []);
      final updatedFollowers = List<String>.from(targetUser.followers ?? []);

      if (!updatedFollowing.contains(targetUserId))
        updatedFollowing.add(targetUserId);
      if (!updatedFollowers.contains(currentUserId))
        updatedFollowers.add(currentUserId);

      // Transaction update
      transaction.update(
        currentUserRef,
        currentUser.copyWith(following: updatedFollowing).toJson(),
      );
      transaction.update(
        targetUserRef,
        targetUser.copyWith(followers: updatedFollowers).toJson(),
      );
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

      final currentUser = currentSnap.exists
          ? User.fromJson(currentSnap.data()!)
          : throw Exception("Current user not found");

      final targetUser = targetSnap.exists
          ? User.fromJson(targetSnap.data()!)
          : throw Exception("Target user not found");

      final updatedFollowing = List<String>.from(currentUser.following ?? []);
      final updatedFollowers = List<String>.from(targetUser.followers ?? []);

      updatedFollowing.remove(targetUserId);
      updatedFollowers.remove(currentUserId);

      transaction.update(
        currentUserRef,
        currentUser.copyWith(following: updatedFollowing).toJson(),
      );
      transaction.update(
        targetUserRef,
        targetUser.copyWith(followers: updatedFollowers).toJson(),
      );
    });
  }

  @override
  Future<bool> isFollowing({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final currentUserDoc = await firestore
        .collection('users')
        .doc(currentUserId)
        .get();
    if (!currentUserDoc.exists) return false;

    final currentUser = User.fromJson(currentUserDoc.data()!);
    final following = currentUser.following ?? [];

    return following.contains(targetUserId);
  }

  @override
  Future<List<Post>> getSavedPostsByIds(List<String> postIds) async {
    if (postIds.isEmpty) return [];

    final snapshot = await firestore
        .collection('posts')
        .where(FieldPath.documentId, whereIn: postIds)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      // 🔥 postId'yi manuel ekliyoruz
      data['postId'] = doc.id;

      return Post.fromFirestore(data);
    }).toList();
  }

  @override
  Future<List<Post>> loadPostsByCity(String city) async {
    final snapshot = await firestore
        .collection("posts")
        .where("isPublic", isEqualTo: true)
        .where("city", isEqualTo: city)
        .orderBy("createdAt", descending: true)
        .get();

    return snapshot.docs.map((doc) => Post.fromFirestore(doc.data())).toList();
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      final snapshot = await firestore.collection("users").get();

      return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
    } catch (e) {
      print("getAllUsers ERROR: $e");
      return [];
    }
  }
}
