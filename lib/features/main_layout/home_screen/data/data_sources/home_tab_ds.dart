import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders_dto.dart';

abstract interface class HomeTabDataSource{
  Future<GetPendingOrdersDto> getAllPendingOrders();
}