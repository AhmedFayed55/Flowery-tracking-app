import '../../domain/entities/orders_entity.dart';

sealed class HomeTabEvent {}

class GetAllPendingOrdersEvent extends HomeTabEvent {}

class SaveOrderEvent extends HomeTabEvent {
  final OrdersEntity order;
  SaveOrderEvent(this.order);
}

class RejectOrderEvent extends HomeTabEvent {
  final String orderId;
  RejectOrderEvent(this.orderId);
}