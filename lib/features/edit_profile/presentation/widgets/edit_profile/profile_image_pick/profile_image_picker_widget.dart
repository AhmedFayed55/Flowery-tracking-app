import 'dart:io';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_image_dialog.dart';
import 'profile_image_utils.dart';

class ProfileImagePickerWidget extends StatefulWidget {
  final String? initialImageUrl;
  final Function(File?)? onImageSelected;
  final double? size;

  const ProfileImagePickerWidget({
    super.key,
    this.initialImageUrl,
    this.onImageSelected,
    this.size,
  });

  @override
  State<ProfileImagePickerWidget> createState() =>
      _ProfileImagePickerWidgetState();
}

class _ProfileImagePickerWidgetState extends State<ProfileImagePickerWidget> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final imageSize = widget.size ?? screenWidth * 0.3;

    return Stack(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: screenWidth * 0.005),
          ),
          child: ClipOval(
            child: _selectedImage != null
                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                : (widget.initialImageUrl != null
                      ? Image.network(
                          widget.initialImageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person, size: imageSize * 0.5)),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => showProfileImageDialog(
              context: context,
              onPickImage: _pickImage,
              hasImage:
                  _selectedImage != null || widget.initialImageUrl != null,
            ),
            child: buildCameraIcon(context),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        widget.onImageSelected?.call(_selectedImage);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, "${context.localization.failedToPickImage}: $e");
    }
  }
}
