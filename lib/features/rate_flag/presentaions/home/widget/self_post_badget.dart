import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/constants/app_color.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';

class SelfPostBadget extends StatelessWidget {
  const SelfPostBadget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${TextConstants.selfPost}🔥",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
