import 'package:json_annotation/json_annotation.dart';

part 'driver_dto.g.dart';

@JsonSerializable()
class DriverDto {
  @JsonKey(name: "_id")
  final String id;
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  // ignore: non_constant_identifier_names
  final String NID;
  // ignore: non_constant_identifier_names
  final String NIDImg;
  final String email;
  final String? password; // خليها optional عشان مش كل الـ APIs بترجعها
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final String createdAt;

  DriverDto({
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    // ignore: non_constant_identifier_names
    required this.NID,
    // ignore: non_constant_identifier_names
    required this.NIDImg,
    required this.email,
    this.password,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.createdAt,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) =>
      _$DriverDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDtoToJson(this);
}
