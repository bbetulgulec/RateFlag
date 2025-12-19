import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          const SizedBox(height: 16),

          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Galeriden seç"),
            onTap: () {
              Navigator.pop(context);
              cubit.pickFromGallery();
            },
          ),

          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Kameradan çek"),
            onTap: () {
              Navigator.pop(context);
              cubit.pickFromCamera();
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
