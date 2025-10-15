import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/response/change_password_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/apply_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';
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

  @PUT(ApiConstants.ordersState)
  Future<void> updateOrderStatusApi(
    @Path("id") String orderId,
    @Body() Map<String, dynamic> body,
  );
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

  @POST(ApiConstants.applyDriver)
  @MultiPart()
  Future<ApplyResponceDto> apply(@Body() FormData formData);

  @GET(ApiConstants.getAllVehicles)
  Future<VehiclesResponseDto> getAllVehicles();

  @PATCH(ApiConstants.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
    @Body() ChangePasswordRequestDto changePasswordRequestDto,
  );
  @GET(ApiConstants.getAllDriverOrders)
  Future<GetAllOrdersResponse> getAllDriverOrders();
}
