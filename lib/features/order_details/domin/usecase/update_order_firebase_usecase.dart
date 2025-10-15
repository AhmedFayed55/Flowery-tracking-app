import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderFirebaseUsecase {
  OrderDetailsRepo orderDetailsRepo;
  UpdateOrderFirebaseUsecase(this.orderDetailsRepo);
  Future<FirebaseResult> invoke(String orderId, RiderOrderStatus status) {
    return orderDetailsRepo.updateOrderStatusFirebase(orderId, status);
  }
}
