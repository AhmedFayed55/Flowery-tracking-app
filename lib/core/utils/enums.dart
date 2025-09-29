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
}
