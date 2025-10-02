enum RiderOrderStatus {
  pending,
  arrivedAtPickup,
  startDelivery,
  arrivedToUser,
  delivered;

  String get statusText {
    switch (this) {
      case RiderOrderStatus.pending:
        return 'Pending';
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

  RiderOrderStatus nextStatus() {
    switch (this) {
      case RiderOrderStatus.pending:
        return RiderOrderStatus.arrivedAtPickup;
      case RiderOrderStatus.arrivedAtPickup:
        return RiderOrderStatus.startDelivery;
      case RiderOrderStatus.startDelivery:
        return RiderOrderStatus.arrivedToUser;
      case RiderOrderStatus.arrivedToUser:
        return RiderOrderStatus.delivered;
      case RiderOrderStatus.delivered:
        return RiderOrderStatus.delivered; // No further status
    }
  }

  int get statusStep {
    switch (this) {
      case RiderOrderStatus.pending:
        return 1;
      case RiderOrderStatus.arrivedAtPickup:
        return 2;
      case RiderOrderStatus.startDelivery:
        return 3;
      case RiderOrderStatus.arrivedToUser:
        return 4;
      case RiderOrderStatus.delivered:
        return 5;
    }
  }

  String get nextStatusButto {
    switch (this) {
      case RiderOrderStatus.pending:
        return 'Arrived at Pickup point';
      case RiderOrderStatus.arrivedAtPickup:
        return 'Start Delivery';
      case RiderOrderStatus.startDelivery:
        return 'Arrived to User';
      case RiderOrderStatus.arrivedToUser:
        return 'Delivered';
      case RiderOrderStatus.delivered:
        return 'Delivered';
    }
  }

  String get statusValue {
    switch (this) {
      case RiderOrderStatus.pending:
        return 'pending';
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

  static RiderOrderStatus fromString(String value) {
    return RiderOrderStatus.values.firstWhere(
      (e) => e.statusValue == value,
      orElse: () => RiderOrderStatus.pending,
    );
  }

  static RiderOrderStatus fromOrderStatus(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.pending:
        return RiderOrderStatus.arrivedAtPickup;
      case OrderStatus.inProgress:
        return RiderOrderStatus.startDelivery;
      case OrderStatus.canceled:
        return RiderOrderStatus.arrivedAtPickup;
      case OrderStatus.completed:
        return RiderOrderStatus.delivered;
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

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.statusText == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
