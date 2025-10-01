sealed class HomeTabEvent {}

class GetAllPendingOrdersEvent extends HomeTabEvent {}

class RejectOrderEvent extends HomeTabEvent {
  final String orderId;
  RejectOrderEvent(this.orderId);
}