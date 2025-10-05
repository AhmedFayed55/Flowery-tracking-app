import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/firebase_results.dart';
import '../../domain/entities/orders_entity.dart';
import '../maper/maper.dart';

@Injectable(as: HomeTabRepo)
class HomeTabRepoImpl implements HomeTabRepo{

  final HomeTabRemoteDataSource _remoteDataSource;
  final HomeTabFirebaseDataSource _firebaseDataSource;
  HomeTabRepoImpl(this._remoteDataSource, this._firebaseDataSource);


   @override
   Future<ApiResult<GetPendingOrdersEntity>> getAllPendingOrders() async {
     return await safeApiCall(() async {
       final response = await _remoteDataSource.getAllPendingOrders();
       return toGetPendingOrdersEntity(response);
     });
   }

  @override
  Future<FirebaseResult<void>> saveOrder(OrdersEntity order) async {
    return await safeFirebaseCall<void>(() async {
      final dto = toOrdersDto(order);
      return await _firebaseDataSource.saveOrder(dto);
    });
  }

}