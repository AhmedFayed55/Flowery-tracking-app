import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppBarEditProfile extends StatelessWidget {
  const AppBarEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.edit_profile,
          style: context.textTheme.labelMedium!.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
