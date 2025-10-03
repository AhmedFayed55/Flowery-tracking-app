import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VehicleViewModel extends Cubit<VehicleState> {
  final AllVehiclesUseCase _allVehiclesUseCase;
  final TextEditingController carNumberController = TextEditingController();

  VehicleViewModel(this._allVehiclesUseCase) : super(VehicleState());

  Future<void> doIntent(VehicleEvent event) async {
    switch (event) {
      case GetVehiclesEvent():
        await _getAllVehicles();
        break;
    }
  }

  Future<void> _getAllVehicles() async {
    var result = await _allVehiclesUseCase();
    switch (result) {
      case ApiSuccessResult():
        return emit(state.copyWith(vehicleEntity: result.data.vehicles));
      case ApiErrorResult():
        return emit(state.copyWith(errorMessage: result.failure.errorMessage));
    }
  }
}
