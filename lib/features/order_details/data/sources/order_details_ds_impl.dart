import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/services/firebase_services.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/orders_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/sources/order_details_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsDs)
class OrderDetailsDsImpl implements OrderDetailsDs {
  final FirebaseService _firebaseService;
  final ApiServices _apiServices;

  OrderDetailsDsImpl(this._firebaseService, this._apiServices);
  @override
  Future<OrdersDto?> getOrderDetails(String orderId) async {
    var result = await _firebaseService.getData('orders', orderId);
    if (!result.exists) {
      return null;
    }

    return OrdersDto.fromJson(result.data() as Map<String, dynamic>);
  }

  @override
  Future<void> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  ) {
    return _firebaseService.updateData('orders', orderId, {
      'state': status.statusValue,
    });
  }

  @override
  Future<void> updateOrderStatusApi(String orderId, OrderStatus status) {
    return _apiServices.updateOrderStatusApi(orderId, {
      'state': status.statusText,
    });
  }
}
