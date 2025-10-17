import 'package:flowery_tracking_app/features/orders_page/data/models/metadata_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/orders_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_orders_response.g.dart';

@JsonSerializable()
class GetAllOrdersResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "orders")
  final List<OrdersDto>? orders;

  GetAllOrdersResponse({this.message, this.metadata, this.orders});

  factory GetAllOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllOrdersResponseToJson(this);
  }

  GetAllOrdersEntity toEntity() {
    return GetAllOrdersEntity(
      message: message,
      metadataDtoEntity: metadata?.toEntity(),
      ordersDtoEntity: orders?.map((order) => order.toEntity()).toList(),
    );
  }
}
