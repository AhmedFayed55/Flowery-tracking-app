import 'dart:io';

import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/image_paker_field.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/selected_car_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicelFields extends StatelessWidget {
  final ApplyViewModel cubit;
  final Function(String) onCarSelected;
  final Function(File?) onLicensePicked;

  const VehicelFields({
    super.key,
    required this.cubit,
    required this.onLicensePicked,
    required this.onCarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        BlocBuilder<ApplyViewModel, ApplyState>(
          buildWhen: (previous, current) =>
              previous.vehicelEntity != current.vehicelEntity,
          builder: (context, state) {
            final vehicles = state.vehicelEntity ?? [];
            return SelectedCarTextField(
              cars: vehicles,
              onCarSelected: onCarSelected,
            );
          },
        ),
        TextFormField(
          controller: cubit.carNumberController,
          validator: (value) => Validations.validateRequired(context, value),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.vehicle_number,
            hintText: AppLocalizations.of(context)!.enter_vehicle_number,
          ),
        ),

        ImageField(
          key: const Key('ImageFieldKey'),
          label: AppLocalizations.of(context)!.license_image,
          hint: AppLocalizations.of(context)!.upload_license_image,
          onImagePicked: onLicensePicked,
        ),
      ],
    );
  }
}
