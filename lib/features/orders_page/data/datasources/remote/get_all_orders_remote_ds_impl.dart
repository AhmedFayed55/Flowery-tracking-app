import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';
import 'package:injectable/injectable.dart';

import 'get_all_orders_remote_ds.dart';

@Injectable(as: GetAllOrdersRemoteDataSource)
class GetAllOrdersRemoteDataSourceImpl implements GetAllOrdersRemoteDataSource {
  ApiServices apiServices;

  GetAllOrdersRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<GetAllOrdersResponse> getAllDriverOrders() async {
    var getAllOrdersResponse = await apiServices.getAllDriverOrders();
    return getAllOrdersResponse;
  }
}
