import 'package:json_annotation/json_annotation.dart';

part 'shipping_address.g.dart';

@JsonSerializable()
class ShippingAddressDto {
  String? street;
  String? city;
  String? phone;
  String? lat;
  String? long;

  ShippingAddressDto({this.street, this.city, this.phone, this.lat, this.long});

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) {
    return _$ShippingAddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShippingAddressDtoToJson(this);
}
