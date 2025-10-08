import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/logged_driver_data.dart';

abstract interface class HomeTabRemoteDataSource{
  Future<GetPendingOrdersDto> getAllPendingOrders();
  Future<LoggedDriverDto> getLoggedDriverData();
}