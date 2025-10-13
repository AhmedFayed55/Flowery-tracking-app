import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/main_profile/data/models/logout/logout_response_dto.dart';
part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(ApiConstants.mainProfile)
  Future<DriverDto> getProfile();

  @GET("${ApiConstants.getVehicle}/{vehicle}")
  Future<VehicleDto> getVehicle(@Path("vehicle") String vehicleType);

  @GET(ApiConstants.logout)
  Future<LogoutResponseDto> logout();
}
