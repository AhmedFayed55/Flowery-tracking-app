import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';

class ContactFields extends StatelessWidget {
  final ApplyViewModel cubit;
  const ContactFields({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TextFormField(
          validator: (value) => Validations.validateRequired(context, value),
          controller: cubit.emailController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.email,
            hintText: AppLocalizations.of(context)!.enter_your_email,
          ),
        ),
        TextFormField(
          validator: (value) => Validations.validateRequired(context, value),
          controller: cubit.phoneController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.phone_number,
            hintText: AppLocalizations.of(context)!.enter_phone_number,
          ),
        ),
      ],
    );
  }
}
