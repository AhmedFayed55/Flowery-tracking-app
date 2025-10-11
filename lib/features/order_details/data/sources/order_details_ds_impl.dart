import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/core/services/firebase_services.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/core/utils/firebase_constant.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/sources/order_details_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsDs)
class OrderDetailsDsImpl implements OrderDetailsDs {
  final FirebaseService _firebaseService;

  OrderDetailsDsImpl(this._firebaseService,);
  @override
  Future<OrdersDto?> getOrderDetails(String orderId) async {
    var result = await _firebaseService.getData(FirebaseConstant.orders, orderId);
    if (!result.exists) {
      return null;
    }

    return OrdersDto.fromJson(
      (result.data() as Map<String, dynamic>)[FirebaseConstant.orders],
    );
  }

  @override
  Future<void> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  ) {
    return _firebaseService.updateData(FirebaseConstant.orders, orderId, {
      FirebaseConstant.orderState: status.statusValue,
    });
  }

  @override
  Future<void> updateDriverLocation(String orderId, String location) async {
    return _firebaseService.updateData(FirebaseConstant.orders, orderId, {
     FirebaseConstant.driverLocation : location,
    });
  }


  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamOrder(String orderId) {
    return _firebaseService
        .streamData(FirebaseConstant.orders, orderId)
        .map((snapshot) => snapshot as DocumentSnapshot<Map<String, dynamic>>);
  }
}
