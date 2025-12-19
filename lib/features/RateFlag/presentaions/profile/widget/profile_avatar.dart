import 'dart:io';
import 'package:flutter/material.dart';

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
            backgroundColor: Colors.grey.shade300,
            backgroundImage: backgroundImage,
            child: backgroundImage == null
                ? Icon(Icons.person, size: radius * 1.3, color: Colors.white)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              radius: radius / 3,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                size: radius / 2.5,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
