import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderDetailsUsecase {
  final OrderDetailsRepo orderDetailsRepo;
  GetOrderDetailsUsecase(this.orderDetailsRepo);
  Future<FirebaseResult<OrdersEntity>> invoke(String orderId) {
    return orderDetailsRepo.getOrderDetails(orderId);
  }
}
