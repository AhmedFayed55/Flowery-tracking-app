import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routing/app_routes.dart';
import '../../../../core/helpers/flutter_toast.dart';
import '../../../../core/utils/font_weight.dart';
import '../manager/profile_view_model.dart';

class LogoutAlertDialogue extends StatelessWidget {
  const LogoutAlertDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = context.localization;
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        localizations.logout,
        textAlign: TextAlign.center,
        style: theme.textTheme.labelMedium!.copyWith(
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
      content: Text(
        localizations.confirm_logout,
        textAlign: TextAlign.center,
        style: theme.textTheme.displayMedium!.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: BorderSide(color: theme.colorScheme.onSurface),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  localizations.cancel,
                  style: theme.textTheme.displaySmall!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state.errorMsgLogout != null) {
                    context.pop();
                    ToastMessage.toastMsg(
                      state.errorMsgLogout!,
                      backgroundColor: theme.colorScheme.error,
                    );
                  }
                  if (state.isSuccessLogout) {
                    context.pop();
                    getIt<SharedPrefHelper>().removeData(key: AppConstants.token);
                    context.pushReplacementNamed(AppRoutes.login);
                    ToastMessage.toastMsg(localizations.logout_successfully);
                  }
                },
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () =>
                      context.read<ProfileCubit>().doIntent(LogoutEvent()),
                  child: Text(
                    localizations.logout,
                    style: theme.textTheme.displayMedium!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
