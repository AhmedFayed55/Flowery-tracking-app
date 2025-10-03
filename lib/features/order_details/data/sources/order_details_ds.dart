import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/orders_dto.dart';

abstract interface class OrderDetailsDs {
  Future<OrdersDto?> getOrderDetails(String orderId);
  Future<void> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  );
  Future<void> updateOrderStatusApi(String orderId, OrderStatus status);
}
