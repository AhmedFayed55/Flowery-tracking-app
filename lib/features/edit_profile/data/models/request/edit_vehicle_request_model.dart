import 'package:json_annotation/json_annotation.dart';

part 'edit_vehicle_request_model.g.dart';

@JsonSerializable()
class EditVehicleRequestModel {
  @JsonKey(name: 'vehicleType')
  final String vehicleType;

  @JsonKey(name: 'vehicleNumber')
  final String vehicleNumber;

  @JsonKey(name: 'vehicleLicense')
  final String vehicleLicense;

  EditVehicleRequestModel({
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
  });

  factory EditVehicleRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditVehicleRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditVehicleRequestModelToJson(this);
}
