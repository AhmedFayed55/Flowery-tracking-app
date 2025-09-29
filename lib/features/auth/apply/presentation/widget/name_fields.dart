import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  const NameFields({super.key, required this.cubit});
  final ApplyViewModel cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: cubit.firstNameController,
          validator: (value) => Validations.validateName(context, value),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.first_name,
            hintText: AppLocalizations.of(context)!.enter_first_name,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: cubit.lastNameController,
          validator: (value) => Validations.validateName(context, value),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.last_name,
            hintText: AppLocalizations.of(context)!.enter_last_name,
          ),
        ),
      ],
    );
  }
}
