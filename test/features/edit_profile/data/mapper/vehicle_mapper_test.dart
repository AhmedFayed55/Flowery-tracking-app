import 'package:flowery_tracking_app/features/edit_profile/data/mapper/vehicle_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';

void main() {
  test(
    'verify when call toModel on EditVehicleRequestEntity it should return model',
    () {
      final mockEntity = EditVehicleRequestEntity(
        vehicleType: 'Car',
        vehicleNumber: '1234',
        vehicleLicense: 'ABC123',
      );

      final result = mockEntity.toModel();

      expect(result, isA<EditVehicleRequestModel>());
      expect(result.vehicleType, mockEntity.vehicleType);
      expect(result.vehicleNumber, mockEntity.vehicleNumber);
      expect(result.vehicleLicense, mockEntity.vehicleLicense);
    },
  );

  test('verify when call toEntity on VehicleDto it should return entity', () {
    final mockDto = VehicleDto(
      id: "1",
      type: 'Truck',
      image: 'truck.png',
      createdAt: "2023-01-01",
      updatedAt: "2023-01-01",
      v: 1,
    );

    final result = mockDto.toEntity();

    expect(result, isA<VehicleEntity>());
    expect(result.id, mockDto.id);
    expect(result.type, mockDto.type);
    expect(result.image, mockDto.image);
  });

  test(
    'verify when call toEntity on VehiclesResponseDto it should return entity',
    () {
      final mockVehicleDto = VehicleDto(
        id: "1",
        type: 'Bike',
        image: 'bike.png',
        createdAt: "2023-01-01",
        updatedAt: "2023-01-01",
        v: 1,
      );
      final mockResponseDto = VehicleResponseDto(
        message: 'Success',
        vehicles: [mockVehicleDto],
      );

      final result = mockResponseDto.toEntity();

      expect(result, isA<VehiclesResponseEntity>());
      expect(result.message, mockResponseDto.message);
      expect(result.vehicles.length, mockResponseDto.vehicles.length);
      expect(result.vehicles.first.type, mockVehicleDto.type);
    },
  );
}
