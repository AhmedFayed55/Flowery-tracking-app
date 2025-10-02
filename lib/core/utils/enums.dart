enum RiderOrderStatus {
  arrivedAtPickup,
  startDelivery,
  arrivedToUser,
  delivered;

  String get statusText {
    switch (this) {
      case RiderOrderStatus.arrivedAtPickup:
        return 'Arrived at Pickup point';
      case RiderOrderStatus.startDelivery:
        return 'Start Delivery';
      case RiderOrderStatus.arrivedToUser:
        return 'Arrived to User';
      case RiderOrderStatus.delivered:
        return 'Delivered';
    }
  }

  String get statusValue {
    switch (this) {
      case RiderOrderStatus.arrivedAtPickup:
        return 'arrivedAtPickup';
      case RiderOrderStatus.startDelivery:
        return 'startDelivery';
      case RiderOrderStatus.arrivedToUser:
        return 'arrivedToUser';
      case RiderOrderStatus.delivered:
        return 'delivered';
    }
  }
}

enum OrderStatus {
  pending,
  inProgress,
  canceled,
  completed;

  String get statusText {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.inProgress:
        return 'inProgress';
      case OrderStatus.canceled:
        return 'canceled';
      case OrderStatus.completed:
        return 'completed';
    }
  }
}
