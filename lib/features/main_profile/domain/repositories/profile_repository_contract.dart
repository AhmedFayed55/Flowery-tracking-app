import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';

abstract class ProfileRepositoryContract {
  Future<ApiResult<DriverDtoEntity>> getProfile();
  Future<ApiResult<VehicleDtoEntity>> getVehicle(String vehicleType);
}
