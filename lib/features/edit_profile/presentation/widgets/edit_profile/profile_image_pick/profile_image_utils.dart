import 'dart:io';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildPlaceholder(double size) {
  return Container(
    color: AppColors.white[10],
    child: Icon(Icons.person, size: size * 0.5, color: AppColors.white[30]),
  );
}

Widget buildProfileImage(widget, File? selectedImage) {
  if (selectedImage != null) {
    return Image.file(
      selectedImage,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildPlaceholder(widget.size),
    );
  } else if (widget.initialImageUrl != null &&
      widget.initialImageUrl!.isNotEmpty) {
    return Image.network(
      widget.initialImageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildPlaceholder(widget.size),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null,
            strokeWidth: context.width * 0.005,
          ),
        );
      },
    );
  }
  return buildPlaceholder(widget.size);
}

Widget buildCameraIcon(BuildContext context) {
  return SvgPicture.asset(
    AppAssets.assetsImagesCamera,
    width: context.width * 0.08,
    height: context.width * 0.08,
  );
}

Widget buildPickerOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color? color,
  required BuildContext context,
}) {
  final screenWidth = context.width;

  return GestureDetector(
    onTap: () {
      onTap();
      Navigator.pop(context);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screenWidth * 0.15,
          height: screenWidth * 0.15,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: (color ?? AppColors.pink).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            size: screenWidth * 0.08,
            color: color ?? AppColors.pink,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: color ?? AppColors.black[70],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildHandleBar(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Container(
    width: screenWidth * 0.2,
    height: screenWidth * 0.01,
    decoration: BoxDecoration(
      color: AppColors.white[30],
      borderRadius: BorderRadius.circular(screenWidth * 0.005),
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.localization.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.localization.ok),
          ),
        ],
      );
    },
  );
}
