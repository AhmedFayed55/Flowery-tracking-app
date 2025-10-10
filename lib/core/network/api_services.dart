import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(ApiConstants.getAllDriverOrders)
  Future<GetAllOrdersResponse> getAllDriverOrders();
}
