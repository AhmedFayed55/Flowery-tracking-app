import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_model_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicel_responce_dto.g.dart';

@JsonSerializable()
class VehiclesResponseDto {
  final String message;
  final List<VehicleModelDto> vehicles;

  VehiclesResponseDto({required this.message, required this.vehicles});

  factory VehiclesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehiclesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesResponseDtoToJson(this);
}
