import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/apply_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
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
  Future<VehiclesResponseDto>getAllVehicles();
}
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../features/main_layout/home_screen/data/models/get_pending_orders_dto.dart';
import 'package:dio/dio.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(ApiConstants.getAllPendingOrders)
  Future<GetPendingOrdersDto> getAllPendingOrders();

}
