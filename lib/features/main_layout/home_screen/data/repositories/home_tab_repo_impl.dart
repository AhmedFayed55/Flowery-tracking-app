import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/to_firebase/to_firebase_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/firebase_result.dart';
import '../maper/to_dto_maper.dart';
import '../maper/to_entity_maper.dart';

@Injectable(as: HomeTabRepo)
class HomeTabRepoImpl implements HomeTabRepo {
  final HomeTabRemoteDataSource _remoteDataSource;
  final HomeTabFirebaseDataSource _firebaseDataSource;
  HomeTabRepoImpl(this._remoteDataSource, this._firebaseDataSource);

  @override
  Future<ApiResult<GetPendingOrdersEntity>> getAllPendingOrders({
    required int page,
    int? limit,
  }) async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.getAllPendingOrders(
        page: page,
        limit: limit,
      );
      return toGetPendingOrdersEntity(response);
    });
  }

  @override
  Future<FirebaseResult<void>> saveOrder(ToFirebaseEntity model) async {
    return await safeFirebaseCall<void>(() async {
      final dto = toFirebaseDto(model);
      return await _firebaseDataSource.saveOrder(dto);
    });
  }

  @override
  Future<ApiResult<DriverDataEntity>> getLoggedDriverData() async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.getLoggedDriverData();
      return toDriverDataEntity(response.driver!);
    });
  }
}
