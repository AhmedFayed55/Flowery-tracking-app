import 'package:flowery_tracking_app/features/order_details/domin/entites/order_items_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/shipping_address_entity.dart';

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
    this.shippingAddress,
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
  ShippingAddressEntity? shippingAddress;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  num? v;
  StoreEntity? store;

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "orderItems": orderItems,
    "totalPrice": totalPrice,
    "paymentType": paymentType,
    "isPaid": isPaid,
    "isDelivered": isDelivered,
    "shippingAddress": shippingAddress,
    "state": state,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "orderNumber": orderNumber,
    "__v": v,
    "store": store,
  };
}
