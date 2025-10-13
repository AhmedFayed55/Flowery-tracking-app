import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            verticalSpace(MediaQuery.of(context).size.height * 0.098),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.2),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.4),
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.6),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withValues(alpha: 0.8),
                  ),
                ),
                const Icon(Icons.check, size: 24, color: Colors.white),
              ],
            ),
            verticalSpace(32),
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
            verticalSpace(48),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.done),
            ),
          ],
        ),
      ),
    );
  }
}
