import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/comment.dart';
import 'package:rate_flag/features/RateFlag/domain/entity/user.dart' as myuser;
import 'package:rate_flag/features/RateFlag/presentaions/post_info/cubit/post_info_state.dart';

class PostCommentsSection extends StatelessWidget {
  final RequestStatus status;
  final List<Comment> comments;
  final Map<String, myuser.User> commentUsers;

  const PostCommentsSection({
    super.key,
    required this.status,
    required this.comments,
    required this.commentUsers,
  });

  @override
  Widget build(BuildContext context) {
    // ⏳ Loading + Initial
    if (status == RequestStatus.loading || status == RequestStatus.initial) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // 📭 Empty
    if (comments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text("Henüz yorum yok"),
      );
    }

    // 🗨️ Comments
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        final user = commentUsers[comment.userId];

        // Kullanıcı henüz yüklenmediyse placeholder göster
        if (user == null) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: const SizedBox(
              height: 40,
              child: Center(child: CircularProgressIndicator(strokeWidth: 1)),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: user.photoUrl != null
                    ? NetworkImage(user.photoUrl!)
                    : null,
                backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                child: user.photoUrl == null
                    ? Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.surface,
                        size: 20.sp,
                      )
                    : null,
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.h),
                    Text(comment.content),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
