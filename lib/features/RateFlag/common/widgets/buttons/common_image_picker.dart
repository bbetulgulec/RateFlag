import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';

class CommonImagePicker extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickFromGallery;
  final VoidCallback onPickFromCamera;
  final double size;

  const CommonImagePicker({
    super.key,
    required this.selectedImage,
    required this.onPickFromGallery,
    required this.onPickFromCamera,
    this.size = 180,
  });

  void _showPickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(TextConstants.selectGallary),
                onTap: () {
                  Navigator.pop(context);
                  onPickFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(TextConstants.selectCamera),
                onTap: () {
                  Navigator.pop(context);
                  onPickFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPickerSheet(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: selectedImage == null
            ? Icon(
                Icons.image,
                size: 60.sp,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withAlpha(100),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(selectedImage!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
