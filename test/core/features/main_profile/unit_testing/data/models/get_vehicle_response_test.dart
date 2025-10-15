import 'package:flowery_tracking_app/features/main_profile/data/models/response/get_vehicle_response.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/get_vehicle_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String message;
  late VehicleDto vehicleDto;

  setUpAll(() {
    message = "success";
    vehicleDto = VehicleDto(id: "1");
  });

  test("test GetVehicleResponse to GetVehicleEntity", () {
    // Arrange
    GetVehicleResponse getVehicleResponse = GetVehicleResponse(
      message: message,
      vehicleDto: vehicleDto,
    );

    GetVehicleEntity getVehicleEntity = GetVehicleEntity(
      message: message,
      vehicleDtoEntity: VehicleDtoEntity(id: vehicleDto.id),
    );

    // Act
    var result = getVehicleResponse.toEntity();

    // Assert
    expect(result.message, equals(getVehicleEntity.message));
    expect(
      result.vehicleDtoEntity?.id,
      equals(getVehicleEntity.vehicleDtoEntity?.id),
    );
  });
}
