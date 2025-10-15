import 'package:flowery_tracking_app/features/orders_page/data/models/store_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/orders_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_dto.dart';

part 'orders_dto.g.dart';

@JsonSerializable()
class OrdersDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "driver")
  final String? driver;
  @JsonKey(name: "order")
  final OrderDto? orderDto;
  @JsonKey(name: "__v")
  final int? V;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "store")
  final StoreDto? storeDto;

  OrdersDto({
    this.id,
    this.driver,
    this.orderDto,
    this.V,
    this.createdAt,
    this.updatedAt,
    this.storeDto,
  });

  factory OrdersDto.fromJson(Map<String, dynamic> json) {
    return _$OrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersDtoToJson(this);
  }

  OrdersDtoEntity toEntity() {
    return OrdersDtoEntity(
      id: id,
      driver: driver,
      orderDtoEntity: orderDto?.toEntity(),
      V: V,
      createdAt: createdAt,
      updatedAt: updatedAt,
      storeDtoEntity: storeDto?.toEntity(),
    );
  }
}
