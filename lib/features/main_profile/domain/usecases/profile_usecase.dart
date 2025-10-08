import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileUseCase {
  ProfileRepositoryContract profileRepositoryContract;

  ProfileUseCase({required this.profileRepositoryContract});

  Future<ApiResult<DriverDtoEntity>> getProfile() async {
    var driverResult = await profileRepositoryContract.getProfile();
    return driverResult;
  }

  Future<ApiResult<VehicleDtoEntity>> getVehicle(String vehicleType) async {
    var vehicleResult = await profileRepositoryContract.getVehicle(vehicleType);
    return vehicleResult;
  }
}
