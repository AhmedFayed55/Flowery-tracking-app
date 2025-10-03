import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/core/utils/assets.dart';
import 'package:flowery_tracking_app/core/utils/font_weight.dart';
import 'package:flutter/material.dart';

class ApplicationApprovedScreen extends StatelessWidget {
  const ApplicationApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Image.asset(
              AppAssets.approvedScreenShadow,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.approved),
                  verticalSpace(size.height * 0.03),
                  Text(
                    localizations.your_application_submitted,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                  verticalSpace(size.height * 0.02),
                  Text(
                    localizations.thank_you_for_providing,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: AppFontWeight.regular,
                    ),
                  ),
                  verticalSpace(size.height * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      context.pushReplacementNamed(AppRoutes.onBoarding);
                    },
                    child: Text(localizations.login),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
