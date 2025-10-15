import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class AppBarApply extends StatelessWidget {
  const AppBarApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.welcom,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 20),
        ),

        Text(
          '${AppLocalizations.of(context)!.want_delivery}\n${AppLocalizations.of(context)!.join_team}',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
