import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rate_flag/core/responsive/responsive.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final String? imageUrl;
  final File? selectedImage;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.radius,
    this.imageUrl,
    this.selectedImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;

    if (selectedImage != null) {
      backgroundImage = FileImage(selectedImage!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      backgroundImage = NetworkImage(imageUrl!);
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundImage: backgroundImage,
            child: backgroundImage == null ? Icon(Icons.person) : null,
          ),
          Positioned(
            bottom: 0.h,
            right: 10.h,
            child: CircleAvatar(
              radius: radius / 4,
              child: Icon(Icons.camera_alt, size: radius / 3),
            ),
          ),
        ],
      ),
    );
  }
}
