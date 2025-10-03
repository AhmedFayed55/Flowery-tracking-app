import 'dart:io';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

class ApplyRequestDto {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final File vehicleLicense;
  @JsonKey(name: 'NID')
  final String nID;
  @JsonKey(name: 'NIDImg')
  final File nIDImg;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final String phone;

  ApplyRequestDto({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nID,
    required this.nIDImg,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.gender,
    required this.phone,
  });

  Map<String, dynamic> toPartMap() {
    return {
      "country": country,
      "firstName": firstName,
      "lastName": lastName,
      "vehicleType": vehicleType,
      "vehicleNumber": vehicleNumber,
      "NID": nID,
      "email": email,
      "password": password,
      "rePassword": rePassword,
      "gender": gender,
      "phone": phone,
    };
  }

  Future<MultipartFile> get vehicleLicensePart async =>
      await MultipartFile.fromFile(
        vehicleLicense.path,
        filename: vehicleLicense.uri.pathSegments.last,
      );

  Future<MultipartFile> get nIDImgPart async => await MultipartFile.fromFile(
    nIDImg.path,
    filename: nIDImg.uri.pathSegments.last,
  );

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toPartMap(),
      "vehicleLicense": await vehicleLicensePart,
      "NIDImg": await nIDImgPart,
    });
  }
}
