import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(ApiConstants.getDriverData)
  Future<GetLoggedDriverResponseDto> getLoggedUserData();

  @PUT(ApiConstants.editProfile)
  Future<EditProfileResponseDto> editProfile(
    @Body() EditProfileRequestModel editProfileRequest,
  );

  @PUT(ApiConstants.editProfile)
  Future<EditProfileResponseDto> updateVehicle(
    @Body() EditVehicleRequestModel editVehicleRequest,
  );

  @PUT(ApiConstants.uploadProfilePhoto)
  @MultiPart()
  Future<UploadPhotoResponseDto> uploadProfilePhoto(
    @Part(name: "photo") File photo,
  );

  @GET(ApiConstants.getAllVehicles)
  Future<VehiclesResponseDto> getAllVehicles();
}
