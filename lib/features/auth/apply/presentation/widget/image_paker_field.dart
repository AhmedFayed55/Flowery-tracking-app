import 'dart:io';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final String label;
  final String hint;
  final Function(File?) onImagePicked;

  const ImageField({
    super.key,
    required this.label,
    required this.hint,
    required this.onImagePicked,
  });

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      widget.onImagePicked(_selectedImage);
    }
  }

  Future<void> _showPickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.select_image),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              icon: const Icon(Icons.camera_alt),
              label: Text(AppLocalizations.of(context)!.camera),
            ),
            verticalSpace(10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.photo_library),
              label: Text(AppLocalizations.of(context)!.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (_) {
        if (_selectedImage == null) {
          return '${AppLocalizations.of(context)!.please_upload} ${widget.label.toLowerCase()}';
        }
        return null;
      },
      readOnly: true,
      onTap: _showPickerDialog,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: _selectedImage == null
            ? widget.hint
            : AppLocalizations.of(context)!.successfully_uploaded,
        suffixIcon: Icon(
          _selectedImage == null
              ? Icons.file_upload_outlined
              : Icons.check_circle,
          color: _selectedImage == null ? AppColors.black : AppColors.pink,
        ),
      ),
    );
  }
}
