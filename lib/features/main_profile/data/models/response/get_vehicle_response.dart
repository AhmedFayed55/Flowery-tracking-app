import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/get_vehicle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_vehicle_response.g.dart';

@JsonSerializable()
class GetVehicleResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "vehicle")
  final VehicleDto? vehicleDto;

  GetVehicleResponse({this.message, this.vehicleDto});

  factory GetVehicleResponse.fromJson(Map<String, dynamic> json) {
    return _$GetVehicleResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetVehicleResponseToJson(this);
  }

  GetVehicleEntity toEntity() {
    return GetVehicleEntity(
      message: message,
      vehicleDtoEntity: vehicleDto?.toEntity(),
    );
  }
}
