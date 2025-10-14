import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';

import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:injectable/injectable.dart';

import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';

import 'package:retrofit/retrofit.dart';
import '../../features/main_profile/data/models/logout/logout_response_dto.dart';

import 'package:retrofit/retrofit.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import '../../features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import '../../features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import '../../features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import '../../features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import '../../features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import '../../features/auth/login_screen/data/models/login_response_model.dart';
import '../../features/main_profile/data/models/driver_dto.dart';
import '../../features/main_profile/data/models/logout/logout_response_dto.dart';
import '../../features/main_profile/data/models/vehicle_dto.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;


  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() Map<String, dynamic> body);


  @POST(ApiConstants.forgotPassword)
  Future<ForgetPasswordRespone> forgotPassword(
    @Body() ForgotPasswordRequest body,
  );

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyPasswordRespone> verifyCode(@Body() VerifyPasswordBody body);

  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordRespone> resetPassword(@Body() ResetPasswordBody body);



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

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.mainProfile)
  Future<DriverDto> getProfile();

  @GET("${ApiConstants.getVehicle}/{vehicle}")
  Future<VehicleDto> getVehicle(@Path("vehicle") String vehicleType);

  @GET(ApiConstants.logout)
  Future<LogoutResponseDto> logout();

  @POST(ApiConstants.applyDriver)
  @MultiPart()
  Future<ApplyResponceDto> apply(@Body() FormData formData);

  @GET(ApiConstants.getAllVehicles)
  Future<VehiclesResponseDto> getAllVehicles();
}
