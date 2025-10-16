import 'package:flowery_tracking_app/features/orders_page/domain/entities/store_dto_entity.dart';

import 'order_dto_entity.dart';

class OrdersDtoEntity {
  final String? id;
  final String? driver;
  final OrderDtoEntity? orderDtoEntity;
  final int? V;
  final String? createdAt;
  final String? updatedAt;
  final StoreDtoEntity? storeDtoEntity;

  OrdersDtoEntity({
    this.id,
    this.driver,
    this.orderDtoEntity,
    this.V,
    this.createdAt,
    this.updatedAt,
    this.storeDtoEntity,
  });
}
