import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';

extension EditVehicleRequestMapper on EditVehicleRequestEntity {
  EditVehicleRequestModel toModel() {
    return EditVehicleRequestModel(
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
    );
  }
}

extension VehiclesResponseMapper on VehiclesResponseDto {
  VehiclesResponseEntity toEntity() {
    return VehiclesResponseEntity(
      message: message,
      vehicles: vehicles.map((vehicle) => vehicle.toEntity()).toList(),
    );
  }
}

extension VehicleMapper on VehicleDto {
  VehicleEntity toEntity() {
    return VehicleEntity(id: id, type: type, image: image);
  }
}
