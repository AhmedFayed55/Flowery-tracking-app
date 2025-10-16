import 'package:flowery_tracking_app/features/orders_page/data/models/product_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/order_items_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items_dto.g.dart';

@JsonSerializable()
class OrderItemsDto {
  @JsonKey(name: "product")
  final ProductDto? productDto;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItemsDto({this.productDto, this.price, this.quantity, this.id});

  factory OrderItemsDto.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemsDtoToJson(this);
  }

  OrderItemsDtoEntity toEntity() {
    return OrderItemsDtoEntity(
      productDtoEntity: productDto?.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
