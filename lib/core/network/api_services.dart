import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/apply/data/model/responce/apply_responce_dto.dart';
import '../../features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
import '../../features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import '../../features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import '../../features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import '../../features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import '../../features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import '../../features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import '../../features/auth/login_screen/data/models/login_response_model.dart';
import '../../features/edit_profile/data/models/request/edit_profile_request_model.dart';
import '../../features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import '../../features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import '../../features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import '../../features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import '../../features/main_layout/home_screen/data/models/get_pending_orders_dto.dart';

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

  @POST(ApiConstants.applyDriver)
  @MultiPart()
  Future<ApplyResponceDto> apply(@Body() FormData formData);

  @GET(ApiConstants.getAllVehicles)
  Future<VehiclesResponseDto> getAllVehicles();

  @GET(ApiConstants.getAllVehicles)
  Future<VehicleResponseDto> getAllVehicle();

  @GET(ApiConstants.getAllPendingOrders)
  Future<GetPendingOrdersDto> getAllPendingOrders();

  @PUT(ApiConstants.ordersState)
  Future<void> updateOrderStatusApi(
    @Path("id") String orderId,
    @Body() Map<String, dynamic> body,
  );

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
}
