import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';

sealed class OrderDetailsEvent extends Equatable {}

class GetOrderDetailsEvent extends OrderDetailsEvent {
  final String orderId;
  GetOrderDetailsEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class UpdateOrderStatusFirebaseEvent extends OrderDetailsEvent {
  final String orderId;
  final RiderOrderStatus status;

  UpdateOrderStatusFirebaseEvent({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}

final class ChangeToNextStatusEvent extends OrderDetailsEvent {
  final String orderId;

  ChangeToNextStatusEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
