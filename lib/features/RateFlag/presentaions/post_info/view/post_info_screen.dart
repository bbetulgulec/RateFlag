import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/post.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart' as MyUser;
import 'package:rate_flag/features/RateFlag/domain/usecase/firestore/get_user_info.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/functions/calculateAge.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post_info/widget/post_image_widget.dart';

class PostInfoScreen extends StatelessWidget {
  final String postId;
  final Post? post;

  const PostInfoScreen({super.key, required this.postId, this.post});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostInfoCubit>();
    final TextEditingController commentController = TextEditingController();
    final calculateAge = Calculateage();

    // 🔥 INIT
    Future.microtask(() async {
      await cubit.loadPostInfo(postId: postId);

      if (!cubit.isClosed && cubit.state.post != null) {
        await cubit.loadFollowStatus(cubit.state.post!.userId);
      }

      // 🔥 YORUMLARI YÜKLE
      await cubit.loadPostComment(cubit.state.post!);
    });

    return BlocConsumer<PostInfoCubit, PostInfoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoadPostInfoLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final post = state.post;
        final user = state.user;

        if (post == null || user == null) {
          return const Scaffold(body: Center(child: Text("Veri bulunamadı")));
        }

        final age = calculateAge.calculateAge(user.birthDate);

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  cubit.handleToggleFollow(post.userId);
                },
                child: state.isFollowActionLoading
                    ? const SizedBox(
                        width: 80,
                        height: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : Text(
                        state.isFollowing == true ? "Takibi Bırak" : "Takip Et",
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () => cubit.sharePost(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostImageWidget(imageUrl: post.imageUrl, height: 500),
                const SizedBox(height: 16),

                // 👤 User
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("$age"),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // 📍 Location
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("📍 ${post.city} / ${post.district}"),
                ),

                const SizedBox(height: 8),

                // 📝 Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(post.description),
                ),

                const SizedBox(height: 16),

                // 🗨️ COMMENTS
                if (state.isCommentLoading) ...[
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ] else if ((state.comments ?? []).isEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Henüz yorum yok"),
                  ),
                ] else ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.comments!.length,
                    itemBuilder: (context, index) {
                      final comment = state.comments![index];

                      return FutureBuilder<MyUser.User?>(
                        future: cubit.fetchCommentUser(comment.userId),

                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }

                          final commentUser = snapshot.data!;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                    commentUser.photoUrl ??
                                        "https://i.pravatar.cc/150",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${commentUser.firstName} ${commentUser.lastName}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(comment.content),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],

                const SizedBox(height: 16),

                // ✍️ Add comment
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: const InputDecoration(
                            hintText: "Yorum yaz...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      MaterialButton(
                        color: Colors.blue,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                        onPressed: () async {
                          final text = commentController.text.trim();
                          if (text.isEmpty) return;

                          final comment = Comment(
                            commentId: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            postId: postId,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            content: text,
                          );

                          await cubit.addComment(comment);
                          commentController.clear();
                        },
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                InkWell(
                  onTap: () {
                    cubit.toggleSavePost(post);
                  },

                  child: Icon(Icons.save),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
