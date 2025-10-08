import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/product_entity.dart';

class OrderItemsEntity {
  OrderItemsEntity({
      this.product, 
      this.price, 
      this.quantity, 
      this.id,});

  ProductEntity? product;
  num? price;
  num? quantity;
  String? id;

}