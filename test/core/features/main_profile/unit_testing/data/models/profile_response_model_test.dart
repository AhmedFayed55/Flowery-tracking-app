import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/response/profile_response_model.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test ProfileResponseModel to ProfileResponseEntity", () {
    // Arrange
    final driverDto = DriverDto(firstName: "John", lastName: "Doe");

    final profileResponseModel = ProfileResponseModel(
      message: "Success",
      driverDto: driverDto,
    );

    final profileResponseEntity = ProfileResponseEntity(
      message: "Success",
      driverDtoEntity: driverDto.toEntity(),
    );

    // Act
    final result = profileResponseModel.toEntity();

    // Assert
    expect(result.message, equals(profileResponseEntity.message));
    expect(
      result.driverDtoEntity?.firstName,
      equals(profileResponseEntity.driverDtoEntity?.firstName),
    );
  });
}
