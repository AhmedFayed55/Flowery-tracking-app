import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';

class UpdateOrderStateEntity {
  UpdateOrderStateEntity({
      this.message, 
      this.orders,});

  String? message;
  OrdersEntity? orders;


}