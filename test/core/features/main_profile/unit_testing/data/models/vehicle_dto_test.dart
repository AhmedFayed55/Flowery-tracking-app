import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VehicleDto → VehicleDtoEntity', () {
    test(
      'toEntity should correctly convert VehicleDto to VehicleDtoEntity',
      () {
        // Arrange
        final vehicleDto = VehicleDto(id: "123", type: "Car");

        // Act
        final entity = vehicleDto.toEntity();

        // Assert
        expect(entity, isA<VehicleDtoEntity>());
        expect(entity.id, equals(vehicleDto.id));
        expect(entity.type, equals(vehicleDto.type));
      },
    );
  });
}
