import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import '../get_pending_orders/orders_dto.dart';
import '../logged_driver_data/driver_data_dto.dart';

part 'to_firebase_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ToFirebaseDto {
  @JsonKey(name: "userState")
  final String? userState;
  @JsonKey(name: "driverLocation")
  final LatLng? driverLocation;
  @JsonKey(name: "orders")
  final OrdersDto? orders;
  @JsonKey(name: "driverData")
  final DriverDataDto? driverData;

  ToFirebaseDto({
    this.driverData,
    this.orders,
    this.userState,
    this.driverLocation,
  });

  factory ToFirebaseDto.fromJson(Map<String, dynamic> json) {
    return _$ToFirebaseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ToFirebaseDtoToJson(this);
  }
}
