import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_dto.g.dart';

@JsonSerializable()
class VehicleDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;

  VehicleDto({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.V,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) {
    return _$VehicleDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehicleDtoToJson(this);
  }

  VehicleDtoEntity toEntity() {
    return VehicleDtoEntity(
      id: id,
      type: type,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
      V: V,
    );
  }
}
