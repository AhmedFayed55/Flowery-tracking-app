import 'dart:io';

import 'package:flowery_tracking_app/features/auth/apply/data/mapper/mapper_request_to_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/request/apply_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify when mapper request to dto', () {
    RequestApplyEntity applyEntity = RequestApplyEntity(
      country: 'country',
      firstName: 'firstName',
      lastName: 'lastName',
      vehicleType: 'vehicleType',
      vehicleNumber: 'vehicleNumber',
      vehicleLicense: File('path'),
      nID: 'nID',
      nIDImg: File('path'),
      email: 'email',
      gender: 'gender',
      phone: 'phone',
      password: 'password',
      rePassword: 'rePassword',
    );
    ApplyRequestDto result = toModelDto(applyEntity);
    expect(result.email, applyEntity.email);
    expect(result.firstName, applyEntity.firstName);
    expect(result.lastName, applyEntity.lastName);
    expect(result.vehicleType, applyEntity.vehicleType);
    expect(result.vehicleNumber, applyEntity.vehicleNumber);
    expect(result.vehicleLicense.path, applyEntity.vehicleLicense.path);
    expect(result.nID, applyEntity.nID);
    expect(result.nIDImg.path, applyEntity.nIDImg.path);
    expect(result.gender, applyEntity.gender);
    expect(result.phone, applyEntity.phone);
    expect(result.password, applyEntity.password);
    expect(result.rePassword, applyEntity.rePassword);
  });
}
