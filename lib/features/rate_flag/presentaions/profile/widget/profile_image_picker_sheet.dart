import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/cubit/profile_cubit.dart';

class ProfileImagePickerSheet extends StatelessWidget {
  const ProfileImagePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

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
            onTap: () {
              Navigator.pop(context);
              cubit.pickFromGallery();
            },
          ),

          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text(TextConstants.selectCamera),
            onTap: () {
              Navigator.pop(context);
              cubit.pickFromCamera();
            },
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
