import 'package:flowery_tracking_app/features/orders_page/domain/entities/user_dto_entity.dart';

import 'order_items_dto_entity.dart';

class OrderDtoEntity {
  final String? id;
  final UserDtoEntity? userDtoEntity;
  final List<OrderItemsDtoEntity>? orderItemsDtoEntity;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? V;

  OrderDtoEntity({
    this.id,
    this.userDtoEntity,
    this.orderItemsDtoEntity,
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
}
