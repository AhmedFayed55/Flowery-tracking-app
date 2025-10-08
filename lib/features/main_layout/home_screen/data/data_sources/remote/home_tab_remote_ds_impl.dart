import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/logged_driver_data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeTabRemoteDataSource)
class HomeTabRemoteDataSourceImpl implements HomeTabRemoteDataSource {
  final ApiServices _apiServices;
  HomeTabRemoteDataSourceImpl(this._apiServices);

  @override
  Future<GetPendingOrdersDto>
  getAllPendingOrders() async => await _apiServices.getAllPendingOrders(
  );

  @override
  Future<LoggedDriverDto> getLoggedDriverData() {
    return _apiServices.getDriverData(
    );
  }

}
