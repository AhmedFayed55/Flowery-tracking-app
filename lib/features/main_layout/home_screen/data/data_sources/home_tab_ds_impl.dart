import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/home_tab_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeTabDataSource)
class HomeTabDataSourceImpl implements HomeTabDataSource{
  final ApiServices _apiServices;
  HomeTabDataSourceImpl(this._apiServices);

  @override
  Future<GetPendingOrdersDto> getAllPendingOrders() async{
    return await _apiServices.getAllPendingOrders();
  }

}