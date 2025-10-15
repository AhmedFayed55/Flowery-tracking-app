import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/orders_page/data/datasources/remote/get_all_orders_remote_ds.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/repositories/get_all_orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetAllOrdersRepo)
class GetAllOrdersRepoImpl implements GetAllOrdersRepo {
  GetAllOrdersRemoteDataSource getAllOrdersRemoteDataSource;

  GetAllOrdersRepoImpl({required this.getAllOrdersRemoteDataSource});

  @override
  Future<ApiResult<GetAllOrdersEntity>> getAllDriverOrders() async {
    return await safeApiCall<GetAllOrdersEntity>(() async {
      var getAllOrdersResponse = await getAllOrdersRemoteDataSource
          .getAllDriverOrders();
      var getAllOrdersEntity = getAllOrdersResponse.toEntity();
      return getAllOrdersEntity;
    });
  }
}
