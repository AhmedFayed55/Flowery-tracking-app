import 'package:flowery_tracking_app/features/edit_profile/data/data/models/vehicle_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicle_response_dto.g.dart';

@JsonSerializable()
class VehiclesResponseDto {
  final String message;
  final List<VehicleDto> vehicles;

  VehiclesResponseDto({required this.message, required this.vehicles});

  factory VehiclesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehiclesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesResponseDtoToJson(this);
}
