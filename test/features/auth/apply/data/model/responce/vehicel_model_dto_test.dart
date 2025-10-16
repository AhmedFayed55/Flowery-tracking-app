import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_model_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('verify when call to Domain convert to entity', () {
    VehicleModelDto vehicleModelDto = VehicleModelDto(
      id: 'id',
      type: 'type',
      image: 'image',
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
      v: 0,
    );
    var result = vehicleModelDto.toDomain();
    expect(result, isA<VehicelEntity>());
  });
}
