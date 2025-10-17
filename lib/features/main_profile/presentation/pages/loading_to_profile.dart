import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class LoadingToProfile extends StatelessWidget {
  const LoadingToProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.height * 0.13,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: const CircularProgressIndicator(),
    );
  }
}
