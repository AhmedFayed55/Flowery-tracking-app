import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderApiUsecase {
  final OrderDetailsRepo repo;
  UpdateOrderApiUsecase(this.repo);
  Future<ApiResult> invoke(String orderId, OrderStatus status) {
    return repo.updateOrderStatusApi(orderId, status);
  }
}
