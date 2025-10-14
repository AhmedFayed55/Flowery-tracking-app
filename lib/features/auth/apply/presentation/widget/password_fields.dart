import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flutter/material.dart';

class PasswordFields extends StatelessWidget {
  final ApplyViewModel cubit;
  const PasswordFields({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: cubit.passwordController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.password,
              hintText: AppLocalizations.of(context)!.enter_password,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: cubit.confirmPasswordController,
            validator: (value) => Validations.confirmPassword(context, value),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.confirm_password,
              hintText: AppLocalizations.of(context)!.confirm_password,
            ),
          ),
        ),
      ],
    );
  }
}
