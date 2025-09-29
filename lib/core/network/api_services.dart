import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/apply_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(ApiConstants.applyDriver)
  @MultiPart()
  Future<ApplyResponceDto> apply(@Body() FormData formData);

  @GET(ApiConstants.getAllVehicles)
  Future<VehiclesResponseDto> getAllVehicles();
}
