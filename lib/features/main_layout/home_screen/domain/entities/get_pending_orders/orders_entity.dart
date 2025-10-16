import 'order_items_entity.dart';
import 'user_entity.dart';
import 'store_entity.dart';

class OrdersEntity {
  OrdersEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });

  String? id;
  UserEntity? user;
  List<OrderItemsEntity>? orderItems;
  num? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  num? v;
  StoreEntity? store;
}
