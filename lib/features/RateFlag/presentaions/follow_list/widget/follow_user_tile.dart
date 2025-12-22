import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';

class FollowUserTile extends StatelessWidget {
  final String fullName;
  final String? photoUrl;
  final VoidCallback? onTap;
  final int? age;

  const FollowUserTile({
    super.key,
    required this.fullName,
    this.photoUrl,
    this.onTap,
    this.age,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
        child: photoUrl == null
            ? Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
              )
            : null,
      ),
      title: Text(
        fullName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: age != null ? Text("$age ${TextConstants.userAge}") : null,
      onTap: onTap,
    );
  }
}
