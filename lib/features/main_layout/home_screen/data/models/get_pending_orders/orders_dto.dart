import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/store_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_items_dto.dart';

part 'orders_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class OrdersDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final UserDto? user;
  @JsonKey(name: "orderItems")
  final List<OrderItemsDto>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "store")
  final StoreDto? store;

  OrdersDto ({
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

  factory OrdersDto.fromJson(Map<String, dynamic> json) {
    return _$OrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersDtoToJson(this);
  }
}