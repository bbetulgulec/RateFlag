import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class ProfileBuildCount extends StatelessWidget {
  final String label;
  final String count;
  final VoidCallback? onTap;

  const ProfileBuildCount({
    super.key,
    required this.label,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
