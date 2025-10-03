import 'package:flowery_tracking_app/core/utils/enums.dart';

sealed class OrderDetailsEvent {}

class GetOrderDetailsEvent extends OrderDetailsEvent {
  final String orderId;
  GetOrderDetailsEvent({required this.orderId});
}

class UpdateOrderStatusFirebaseEvent extends OrderDetailsEvent {
  final String orderId;
  final RiderOrderStatus status;

  UpdateOrderStatusFirebaseEvent({required this.orderId, required this.status});
}

class UpdateOrderStatusApiEvent extends OrderDetailsEvent {
  final String orderId;
  final OrderStatus status;

  UpdateOrderStatusApiEvent({required this.orderId, required this.status});
}

final class ChangeToNextStatusEvent extends OrderDetailsEvent {
  final String orderId;

  ChangeToNextStatusEvent({required this.orderId});
}
