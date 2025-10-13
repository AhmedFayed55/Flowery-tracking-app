import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/logout/logout_response_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  ApiServices apiServices;

  ProfileRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<DriverDto> getProfile() async {
    DriverDto driverDto = await apiServices.getProfile();
    return driverDto;
  }

  @override
  Future<VehicleDto> getVehicle(String vehicleType) async {
    VehicleDto vehicleDto = await apiServices.getVehicle(vehicleType);
    return vehicleDto;
  }

  @override
  Future<LogoutResponseDto> logout() async{
    return await apiServices.logout();
  }
}
