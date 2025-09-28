import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'driver_model_dto.g.dart';

@JsonSerializable()
class DriverModelDto {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  @JsonKey(name: 'NID')
  final String nID;
  @JsonKey(name: 'NIDImg')
  final String nIDImg;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;

  @JsonKey(name: '_id')
  final String id;

  final String createdAt;

  DriverModelDto({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nID,
    required this.nIDImg,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.id,
    required this.createdAt,
  });

  factory DriverModelDto.fromJson(Map<String, dynamic> json) =>
      _$DriverModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelDtoToJson(this);

  DriverEntity toDomain() {
    return DriverEntity(
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nID: nID,
      nIDImg: nIDImg,
      email: email,
      gender: gender,
      phone: phone,
      photo: phone,
      id: id,
    );
  }
}
