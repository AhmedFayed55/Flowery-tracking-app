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
    return await _apiServices.getAllPendingOrders(
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2OGQ2NTU2ZmRkODkzN2UwNTczZmE0OTYiLCJpYXQiOjE3NTkyNTcyMjV9.hfAYlf5Cg8OYzKzqAhIA7qZOlWr1aZpSyIyrOue8Dks"
    );
  }

}