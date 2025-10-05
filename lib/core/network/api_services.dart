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
