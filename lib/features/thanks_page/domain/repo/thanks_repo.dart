import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';

abstract interface class ThanksRepo {
  Future<ApiResult> updateOrderStatusApi(String orderId, OrderStatus status);
  Future<void> deleteOrderLocal();
}
