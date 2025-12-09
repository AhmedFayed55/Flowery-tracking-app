import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/to_firebase/to_firebase_entity.dart';

import '../../../../../core/errors/firebase_result.dart';

abstract interface class HomeTabRepo {
  Future<ApiResult<GetPendingOrdersEntity>> getAllPendingOrders({
    required int page,
    int? limit,
  });
  Future<ApiResult<DriverDataEntity>> getLoggedDriverData();
  Future<FirebaseResult<void>> saveOrder(ToFirebaseEntity model);
}
