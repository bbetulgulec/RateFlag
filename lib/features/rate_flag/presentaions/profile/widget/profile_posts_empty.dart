import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';

class ProfilePostsEmpty extends StatelessWidget {
  final String mainText;
  final String subText;
  final IconData icon;

  const ProfilePostsEmpty({
    super.key,
    required this.mainText,
    required this.subText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 45.sp,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 10),
        Text(
          mainText,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.h),
        Text(
          subText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
