import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ThanksPageBody extends StatelessWidget {
  const ThanksPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size80height = context.height * 0.1;
    var size32height = context.height * 0.04;
    var size48height = context.height * 0.06;
    var size150height = context.height * 0.18;
    var size150width = context.width * 0.4;
    var size120height = context.height * 0.15;
    var size120width = context.width * 0.32;
    var size90height = context.height * 0.11;
    var size90width = context.width * 0.24;
    var size60height = context.height * 0.07;
    var size60width = context.width * 0.16;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          MediaQuery.of(context).padding.top,
          16,
          16,
        ),
        child: Column(
          children: [
            verticalSpace(size80height),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size150height,
                  height: size150width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.2),
                  ),
                ),
                Container(
                  width: size120height,
                  height: size120width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.3),
                  ),
                ),
                Container(
                  width: size90height,
                  height: size90width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.5),
                  ),
                ),
                Container(
                  width: size60height,
                  height: size60width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.7),
                  ),
                ),
                const Icon(Icons.check, size: 24, color: Colors.white),
              ],
            ),
            verticalSpace(size32height),
            Text(
              AppLocalizations.of(context)!.thank_you,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.green),
            ),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.the_order_delivered_successfully,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpace(size48height),
            ElevatedButton(
              onPressed: () {
                context.pushReplacementNamed(AppRoutes.mainLayout);
              },
              child: Text(AppLocalizations.of(context)!.done),
            ),
          ],
        ),
      ),
    );
  }
}
