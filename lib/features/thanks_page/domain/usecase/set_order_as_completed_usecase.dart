import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/thanks_page/domain/repo/thanks_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetOrderAsCompletedUsecase {
  final ThanksRepo _repo;
  SetOrderAsCompletedUsecase(this._repo);
  Future<ApiResult> invoke(String orderId) {
    return _repo.updateOrderStatusApi(orderId, OrderStatus.completed);
  }
}
