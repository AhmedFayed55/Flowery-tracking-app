import 'dart:io';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_vehicle/selected_car_type.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_vehicle/vehicle_image_pick/image_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicelFields extends StatelessWidget {
  final VehicleViewModel cubit;
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
      spacing: context.height * 0.02,
      children: [
        BlocBuilder<VehicleViewModel, VehicleState>(
          buildWhen: (previous, current) =>
              previous.vehicleEntity != current.vehicleEntity,
          builder: (context, state) {
            final vehicles = state.vehicleEntity ?? [];
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
            labelText: context.localization.vehicle_number,
            hintText: context.localization.enter_vehicle_number,
          ),
        ),

        ImageField(
          label: context.localization.license_image,
          hint: context.localization.upload_license_image,
          onImagePicked: onLicensePicked,
        ),
      ],
    );
  }
}
