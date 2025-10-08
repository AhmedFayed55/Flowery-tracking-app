import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateDriverLocationUsecase {
  OrderDetailsRepo orderDetailsRepo;
  UpdateDriverLocationUsecase(this.orderDetailsRepo);
  Future<FirebaseResult> invoke(String orderId, String location) {
    return orderDetailsRepo.updateDriverLocation(orderId, location);
  }
}