import 'package:flowery_tracking_app/features/auth/apply/data/model/request/apply_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';

ApplyRequestDto toModelDto(RequestApplyEntity entity) {
  return ApplyRequestDto(
    country: entity.country,
    firstName: entity.firstName,
    lastName: entity.lastName,
    vehicleType: entity.vehicleType,
    vehicleNumber: entity.vehicleNumber,
    vehicleLicense: entity.vehicleLicense,
    nID: entity.nID,
    nIDImg: entity.nIDImg,
    email: entity.email,
    password: entity.password,
    rePassword: entity.rePassword,
    gender: entity.gender,
    phone: entity.phone,
  );
}
