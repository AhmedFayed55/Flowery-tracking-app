import 'package:flowery_tracking_app/features/orders_page/data/models/user_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/order_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_items_dto.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final UserDto? userDto;
  @JsonKey(name: "orderItems")
  final List<OrderItemsDto>? orderItemsDto;
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
  final int? V;

  OrderDto({
    this.id,
    this.userDto,
    this.orderItemsDto,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.V,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return _$OrderDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderDtoToJson(this);
  }

  OrderDtoEntity toEntity() {
    return OrderDtoEntity(
      id: id,
      userDtoEntity: userDto?.toEntity(),
      orderItemsDtoEntity: orderItemsDto?.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      V: V,
    );
  }
}
