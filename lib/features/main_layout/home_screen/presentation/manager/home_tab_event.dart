import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';

sealed class HomeTabEvent {}

class GetAllPendingOrdersEvent extends HomeTabEvent {}

class SaveOrderEvent extends HomeTabEvent {
  OrdersEntity order;
  SaveOrderEvent(this.order);
}

class RejectOrderEvent extends HomeTabEvent {
  final String orderId;
  RejectOrderEvent(this.orderId);
}

class GetLoggedDriverDataEvent extends HomeTabEvent {}
