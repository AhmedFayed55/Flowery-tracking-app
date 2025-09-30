import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/home_tab_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../maper/maper.dart';

@Injectable(as: HomeTabRepo)
class HomeTabRepoImpl implements HomeTabRepo{

  final HomeTabDataSource _dataSource;
  HomeTabRepoImpl(this._dataSource);

  @override
  Future<ApiResult<GetPendingOrdersEntity>> getAllPendingOrders() async{
    try {
      final response = await _dataSource.getAllPendingOrders();

      return ApiSuccessResult(
        data: toGetPendingOrdersEntity(response),
      );
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }

}