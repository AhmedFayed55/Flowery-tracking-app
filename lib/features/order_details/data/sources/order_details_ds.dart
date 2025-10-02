import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/order_details/data/model/order_dto.dart';

abstract interface class OrderDetailsDs {
  Future<OrderDto?> getOrderDetails(String orderId);
  Future<void> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  );
  Future<void> updateOrderStatusApi(String orderId, OrderStatus status);
}
