import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders_entity.dart';

import '../../../../../core/errors/firebase_results.dart';
import '../entities/orders_entity.dart';

abstract interface class HomeTabRepo{
  Future<ApiResult<GetPendingOrdersEntity>> getAllPendingOrders();
  Future<FirebaseResult<void>> saveOrder(OrdersEntity order);
}