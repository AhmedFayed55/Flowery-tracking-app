import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/driver_model_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify when call to Domain convert to entity', () {
    DriverModelDto driverModelDto = DriverModelDto(
      country: 'country',
      firstName: 'firstName',
      lastName: 'lastName',
      vehicleType: 'vehicleType',
      vehicleNumber: 'vehicleNumber',
      vehicleLicense: 'vehicleLicense',
      nID: 'nID',
      nIDImg: 'nIDImg',
      email: 'email',
      gender: 'gender',
      phone: 'phone',
      photo: 'photo',
      id: 'id',
      role: '',
      createdAt: '',
    );
    var result = driverModelDto.toDomain();
    expect(result, isA<DriverEntity>());
  });
}
