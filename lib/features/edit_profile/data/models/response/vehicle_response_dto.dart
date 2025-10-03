import 'package:flowery_tracking_app/features/edit_profile/data/models/vehicle_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicle_response_dto.g.dart';

@JsonSerializable()
class VehicleResponseDto {
  final String message;
  final List<VehicleDto> vehicles;

  VehicleResponseDto({required this.message, required this.vehicles});

  factory VehicleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseDtoToJson(this);
}
