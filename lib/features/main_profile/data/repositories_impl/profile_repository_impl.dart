import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/local/profile_local_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepositoryContract)
class ProfileRepositoryImpl extends ProfileRepositoryContract {
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileLocalDataSource profileLocalDataSource;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.profileLocalDataSource,
  });

  @override
  Future<ApiResult<DriverDtoEntity>> getProfile() async {
    return await safeApiCall<DriverDtoEntity>(() async {
      var driverDto = await profileRemoteDataSource.getProfile();
      var driverDtoEntity = driverDto.toEntity();
      return driverDtoEntity;
    });
  }

  @override
  Future<ApiResult<VehicleDtoEntity>> getVehicle(String vehicleType) async{
    return await safeApiCall<VehicleDtoEntity>(() async {
      var vehicleDto = await profileRemoteDataSource.getVehicle(vehicleType);
      var vehicleDtoEntity = vehicleDto.toEntity();
      return vehicleDtoEntity;
    });
  }

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() async{
    return await safeApiCall(() async{
      var dto = await profileRemoteDataSource.logout();
      return dto.toEntity();
    });
  }
}
