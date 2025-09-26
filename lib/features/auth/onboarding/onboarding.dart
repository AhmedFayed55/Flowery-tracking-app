import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/core/utils/assets.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          MediaQuery.of(context).padding.top,
          16,
          52,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppAssets.onBoarding),
            Text(
              AppLocalizations.of(context)!.welcome_to_flowery_rider_app,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontSize: 20),
            ),
            verticalSpace(24),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoutes.login);
              },
              child: Text(AppLocalizations.of(context)!.login),
            ),
            verticalSpace(16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                side: const BorderSide(color: AppColors.darkGrey, width: 1),
              ),
              onPressed: () {
                /// Navigator to Apply Screen
              },
              child: Text(
                AppLocalizations.of(context)!.apply_now,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const Spacer(),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Text(
                AppLocalizations.of(context)!.app_version,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
