import 'package:json_annotation/json_annotation.dart';
part 'vehicle_dto.g.dart';

@JsonSerializable()
class VehicleDto {
  @JsonKey(name: '_id')
  final String id;
  final String type;
  final String image;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  VehicleDto({
    required this.id,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDtoToJson(this);
}
