import 'dart:io';

class RequestApplyEntity {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final File vehicleLicense;
  final String nID;
  final File nIDImg;
  final String email;
  final String gender;
  final String phone;
  final String password;
  final String rePassword;

  RequestApplyEntity({
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
    required this.password,
    required this.rePassword,
  });
}
