import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllPendingOrdersUseCase {
  final HomeTabRepo _repo;

  GetAllPendingOrdersUseCase(this._repo);

  Future<ApiResult<GetPendingOrdersEntity>> invoke() =>
      _repo.getAllPendingOrders();
}
