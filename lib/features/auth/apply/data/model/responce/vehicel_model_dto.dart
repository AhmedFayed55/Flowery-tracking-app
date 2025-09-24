import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicel_model_dto.g.dart';

@JsonSerializable()
class VehicleModelDto {
  @JsonKey(name: '_id')
  final String id;
  final String type;
  final String image;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;

  VehicleModelDto({
    required this.id,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VehicleModelDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelDtoToJson(this);

  VehicelEntity toDomain() {
    return VehicelEntity(id: id, type: type, image: image);
  }
}
