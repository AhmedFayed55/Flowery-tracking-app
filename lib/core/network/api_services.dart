import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

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

}
