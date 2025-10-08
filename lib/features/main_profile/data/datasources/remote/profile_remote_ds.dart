import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<DriverDto> getProfile();

  Future<VehicleDto> getVehicle(String vehicleType);
}
