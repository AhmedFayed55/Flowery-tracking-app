import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_image_utils.dart';

void showProfileImageDialog({
  required BuildContext context,
  required Function(ImageSource source) onPickImage,
  required bool hasImage,
}) {
  final screenWidth = context.width;
  final screenHeight = context.height;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(screenWidth * 0.05),
          ),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                child: Column(
                  children: [
                    buildHandleBar(context),
                    SizedBox(height: screenHeight * 0.025),
                    Text(
                      context.localization.select_profile_picture,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPickerOption(
                          context: context,
                          icon: Icons.camera_alt,
                          label: context.localization.camera,
                          onTap: () => onPickImage(ImageSource.camera),
                        ),
                        buildPickerOption(
                          context: context,
                          icon: Icons.photo_library,
                          label: context.localization.gallery,
                          onTap: () => onPickImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.025),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
