import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';

abstract interface class GetAllOrdersRemoteDataSource {
  Future<GetAllOrdersResponse> getAllDriverOrders();
}
