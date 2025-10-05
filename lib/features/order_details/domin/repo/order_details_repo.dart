import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orders_entity.dart';

abstract interface class OrderDetailsRepo {
  Future<FirebaseResult<OrdersEntity>> getOrderDetails(String orderId);
  Future<FirebaseResult> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  );
  Future<ApiResult> updateOrderStatusApi(String orderId, OrderStatus status);
}
