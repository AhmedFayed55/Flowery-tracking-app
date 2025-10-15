import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/repositories/get_all_orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllOrdersUseCase {
  GetAllOrdersRepo getAllOrdersRepo;

  GetAllOrdersUseCase({required this.getAllOrdersRepo});

  Future<ApiResult<GetAllOrdersEntity>> getAllDriverOrders() async {
    ApiResult<GetAllOrdersEntity> result = await getAllOrdersRepo
        .getAllDriverOrders();
    return result;
  }
}
