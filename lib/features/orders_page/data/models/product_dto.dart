import 'package:flowery_tracking_app/features/orders_page/domain/entities/product_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "price")
  final int? price;

  ProductDto({this.id, this.price});

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return _$ProductDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductDtoToJson(this);
  }

  ProductDtoEntity toEntity() {
    return ProductDtoEntity(id: id, price: price);
  }
}
