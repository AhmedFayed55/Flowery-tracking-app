import 'dart:io';

import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/image_paker_field.dart';
import 'package:flutter/material.dart';

class IdFields extends StatelessWidget {
  final ApplyViewModel cubit;
  final Function(File?) onImageIdPicked;
  const IdFields({
    super.key,
    required this.cubit,
    required this.onImageIdPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TextFormField(
          controller: cubit.idNumberController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.id_number,
            hintText: AppLocalizations.of(context)!.enter_id_number,
          ),
        ),
        
        ImageField(
          label: AppLocalizations.of(context)!.id_image,
          hint: AppLocalizations.of(context)!.upload_id_image,
          onImagePicked: onImageIdPicked,
        ),
      ],
    );
  }
}
