import 'package:json_annotation/json_annotation.dart';

import 'meta_data_dto.dart';
import 'orders_dto.dart';

part 'get_pending_orders_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GetPendingOrdersDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "orders")
  final List<OrdersDto>? orders;

  GetPendingOrdersDto ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory GetPendingOrdersDto.fromJson(Map<String, dynamic> json) {
    return _$GetPendingOrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetPendingOrdersDtoToJson(this);
  }
}













