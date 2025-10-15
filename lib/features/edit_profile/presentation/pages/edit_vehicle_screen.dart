import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_vehicle/form/edit_vehicle_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditVehicleScreen extends StatelessWidget {
  const EditVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<VehicleViewModel>(),
      child: const EditVehicleForm(),
    );
  }
}
