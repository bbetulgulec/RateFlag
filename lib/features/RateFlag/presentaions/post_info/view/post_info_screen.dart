import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';

class PostInfoScreen extends StatefulWidget {
  final String postId;
  final String userId;

  const PostInfoScreen({super.key, required this.postId, required this.userId});

  @override
  State<PostInfoScreen> createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends State<PostInfoScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PostInfoCubit>().loadPostInfo(
      userId: widget.userId,
      postId: widget.postId,
    );
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (!doc.exists) return null;
    return doc.data();
  }

  int calculateAge(String birthDate) {
    final parts = birthDate.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final birth = DateTime(year, month, day);
    final today = DateTime.now();

    int age = today.year - birth.year;

    if (today.month < birth.month ||
        (today.month == birth.month && today.day < birth.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostInfoCubit, PostInfoState>(
      builder: (context, state) {
        if (state.isLoadPostInfoLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(body: Center(child: Text(state.errorMessage!)));
        }

        final post = state.post;
        if (post == null) {
          return const Scaffold(body: Center(child: Text("Post bulunamadı")));
        }

        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 KULLANICI BİLGİSİ
                FutureBuilder<Map<String, dynamic>?>(
                  future: getUser(widget.userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Kullanıcı yükleniyor..."),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Kullanıcı bulunamadı"),
                      );
                    }

                    final user = snapshot.data!;
                    final age = calculateAge(user['birthDate']);

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user['firstName']} ${user['lastName']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$age yaşında",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                /// 🔹 POST
                Image.network(post.imageUrl ?? ''),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(post.description),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("🔴 ${post.redFlag ?? 0}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("🟢 ${post.greenFlag ?? 0}"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
