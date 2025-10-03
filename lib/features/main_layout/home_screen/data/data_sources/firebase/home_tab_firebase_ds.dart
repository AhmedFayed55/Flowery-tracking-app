import '../../models/orders_dto.dart';

abstract interface class HomeTabFirebaseDataSource {
  Future<void> saveOrder(OrdersDto order);
}
