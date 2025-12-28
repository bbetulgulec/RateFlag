import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';

class ProfileImagePickerSheet extends StatelessWidget {
  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  const ProfileImagePickerSheet({
    super.key,
    required this.onPressedCamera,
    required this.onPressedGallery,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),

          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant,

              borderRadius: BorderRadius.circular(8),
            ),
          ),

          SizedBox(height: 16.h),

          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text(TextConstants.selectGallary),
            onTap: onPressedGallery,
            /* () {
              Navigator.pop(context);
              cubit.pickFromGallery();
            }, */
          ),

          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text(TextConstants.selectCamera),
            onTap: onPressedCamera,
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
