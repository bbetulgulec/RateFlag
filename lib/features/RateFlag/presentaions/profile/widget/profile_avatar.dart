import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final String? imageUrl;
  final VoidCallback? onCameraTap;
  const ProfileAvatar({
    super.key,
    required this.radius,
    this.imageUrl,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? Icon(
                  Icons.person,
                  size: radius * 1.33, // 60/45 = 1.33
                  color: Colors.white,
                )
              : null,
        ),
        if (onCameraTap != null)
          Positioned(
            bottom: 0,
            right: 6,
            child: GestureDetector(
              onTap: onCameraTap,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: radius / 2.8, // 16/45 yaklaşık
                child: Icon(
                  Icons.camera_alt,
                  size: radius / 2.5, // 18/45 yaklaşık
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
