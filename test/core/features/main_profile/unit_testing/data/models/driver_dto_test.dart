import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String id;
  late String createdAt;

  setUpAll(() {
    id = "1";
    createdAt = "2025-10-05";
  });

  test("test DriverDto to DriverDtoEntity", () {
    // Arrange
    DriverDto driverDto = DriverDto(id: id, createdAt: createdAt);

    DriverDtoEntity driverDtoEntity = DriverDtoEntity(
      id: id,
      createdAt: createdAt,
    );

    // Act
    var result = driverDto.toEntity();

    // Assert
    expect(result.id, equals(driverDtoEntity.id));
    expect(result.createdAt, equals(driverDtoEntity.createdAt));
  });
}
