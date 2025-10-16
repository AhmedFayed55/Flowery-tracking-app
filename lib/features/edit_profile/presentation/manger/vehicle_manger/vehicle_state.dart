import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';

class VehicleState {
  bool isLoading;
  String errorMessage;
  DriverEntity? driver;
  List<VehicleEntity>? vehicleEntity;
  VehicleState({
    this.isLoading = false,
    this.errorMessage = '',
    this.driver,
    this.vehicleEntity,
  });
  VehicleState copyWith({
    bool? isLoading,
    String? errorMessage,
    DriverEntity? driver,
    List<VehicleEntity>? vehicleEntity,
  }) {
    return VehicleState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      driver: driver ?? this.driver,
      vehicleEntity: vehicleEntity ?? this.vehicleEntity,
    );
  }
}
