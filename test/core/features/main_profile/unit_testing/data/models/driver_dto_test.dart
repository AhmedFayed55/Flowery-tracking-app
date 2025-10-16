import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String id;
  late String type;

  setUpAll(() {
    id = "1";
    type = "Car";
  });

  test("test VehicleDto to VehicleDtoEntity", () {
    // Arrange
    VehicleDto vehicleDto = VehicleDto(id: id, type: type);

    VehicleDtoEntity vehicleDtoEntity = VehicleDtoEntity(id: id, type: type);

    // Act
    var result = vehicleDto.toEntity();

    // Assert
    expect(result.id, equals(vehicleDtoEntity.id));
    expect(result.type, equals(vehicleDtoEntity.type));
  });
}
