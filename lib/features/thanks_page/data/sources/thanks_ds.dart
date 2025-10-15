import 'package:flowery_tracking_app/core/utils/enums.dart';

abstract interface class ThanksDs {
  Future<void> updateOrderStatusApi(String orderId, OrderStatus status);
  Future<void> deleteOrderLocal();
}
