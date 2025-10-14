import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileUseCase {
  ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<ApiResult<DriverDtoEntity>> getProfile() async {
    var driverResult = await profileRepository.getProfile();
    return driverResult;
  }

  Future<ApiResult<VehicleDtoEntity>> getVehicle(String vehicleType) async {
    var vehicleResult = await profileRepository.getVehicle(vehicleType);
    return vehicleResult;
  }
}
