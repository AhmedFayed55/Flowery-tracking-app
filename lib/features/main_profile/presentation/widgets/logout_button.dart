import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/di/di.dart';
import 'logout_alert_dialogue.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: const Icon(Icons.logout, color: AppColors.darkGrey, size: 16),
      title: Text(
        context.localization.logout,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
      ),
      trailing: const Icon(Icons.logout, color: AppColors.darkGrey, size: 24),
      onTap: () => _logout(context),
    );
  }
}


void _logout(context) {
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: getIt<ProfileCubit>(),
        child: const LogoutAlertDialogue(),
      );
    },
  );
}
