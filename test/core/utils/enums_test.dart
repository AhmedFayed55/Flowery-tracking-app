import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("RiderOrderStatus Tests", () {
    test("statusText returns correct text", () {
      expect(RiderOrderStatus.pending.statusText, "Pending");
      expect(RiderOrderStatus.arrivedAtPickup.statusText, "Arrived at Pickup point");
      expect(RiderOrderStatus.startDelivery.statusText, "Start Delivery");
      expect(RiderOrderStatus.arrivedToUser.statusText, "Arrived to User");
      expect(RiderOrderStatus.delivered.statusText, "Delivered");
    });

    test("nextStatus returns correct next value", () {
      expect(RiderOrderStatus.pending.nextStatus(), RiderOrderStatus.arrivedAtPickup);
      expect(RiderOrderStatus.arrivedAtPickup.nextStatus(), RiderOrderStatus.startDelivery);
      expect(RiderOrderStatus.startDelivery.nextStatus(), RiderOrderStatus.arrivedToUser);
      expect(RiderOrderStatus.arrivedToUser.nextStatus(), RiderOrderStatus.delivered);
      expect(RiderOrderStatus.delivered.nextStatus(), RiderOrderStatus.delivered);
    });

    test("statusStep returns correct step number", () {
      expect(RiderOrderStatus.pending.statusStep, 1);
      expect(RiderOrderStatus.arrivedAtPickup.statusStep, 2);
      expect(RiderOrderStatus.startDelivery.statusStep, 3);
      expect(RiderOrderStatus.arrivedToUser.statusStep, 4);
      expect(RiderOrderStatus.delivered.statusStep, 5);
    });

    test("nextStatusButton returns correct label", () {
      expect(RiderOrderStatus.pending.nextStatusButton, "Arrived at Pickup point");
      expect(RiderOrderStatus.arrivedAtPickup.nextStatusButton, "Start Delivery");
      expect(RiderOrderStatus.startDelivery.nextStatusButton, "Arrived to User");
      expect(RiderOrderStatus.arrivedToUser.nextStatusButton, "Delivered");
      expect(RiderOrderStatus.delivered.nextStatusButton, "Delivered");
    });

    test("statusValue returns correct string", () {
      expect(RiderOrderStatus.pending.statusValue, "pending");
      expect(RiderOrderStatus.arrivedAtPickup.statusValue, "arrivedAtPickup");
      expect(RiderOrderStatus.startDelivery.statusValue, "startDelivery");
      expect(RiderOrderStatus.arrivedToUser.statusValue, "arrivedToUser");
      expect(RiderOrderStatus.delivered.statusValue, "delivered");
    });
  });

  group("OrderStatus Tests", () {
    test("statusText returns correct string", () {
      expect(OrderStatus.pending.statusText, "pending");
      expect(OrderStatus.inProgress.statusText, "inProgress");
      expect(OrderStatus.canceled.statusText, "canceled");
      expect(OrderStatus.completed.statusText, "completed");
    });

    test("fromString returns correct enum or fallback", () {
      expect(OrderStatus.fromString("inProgress"), OrderStatus.inProgress);
      expect(OrderStatus.fromString("invalid"), OrderStatus.pending);
    });
  });
}
