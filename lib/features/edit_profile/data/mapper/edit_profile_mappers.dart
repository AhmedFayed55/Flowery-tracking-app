import 'package:flowery_tracking_app/features/edit_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';

extension EditProfileResponseMapper on EditProfileResponseDto {
  EditProfileResponseEntity toEntity() {
    return EditProfileResponseEntity(
      message: message,
      driver: driver.toEntity(),
    );
  }
}

extension EditProfileRequestMapper on EditProfileRequestEntity {
  EditProfileRequestModel toModel() {
    return EditProfileRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}

extension GetLoggedDriverResponseMapper on GetLoggedDriverResponseDto {
  GetLoggedDriverResponseEntity toEntity() {
    return GetLoggedDriverResponseEntity(
      message: message,
      driver: driver.toEntity(),
    );
  }
}

extension DriverMapper on DriverDto {
  DriverEntity toEntity() {
    return DriverEntity(
      id: id,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      NID: NID,
      NIDImg: NIDImg,
      email: email,
      password: password,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      createdAt: createdAt,
    );
  }
}
