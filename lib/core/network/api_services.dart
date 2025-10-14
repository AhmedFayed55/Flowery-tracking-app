import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
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

  @GET(ApiConstants.mainProfile)
  Future<DriverDto> getProfile();

  @GET("${ApiConstants.getVehicle}/{vehicle}")
  Future<VehicleDto> getVehicle(@Path("vehicle") String vehicleType);

  @GET(ApiConstants.logout)
  Future<LogoutResponseDto> logout();
}
