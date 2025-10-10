import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';

abstract class GetAllOrdersRepo {
  Future<ApiResult<GetAllOrdersEntity>> getAllDriverOrders();
}
