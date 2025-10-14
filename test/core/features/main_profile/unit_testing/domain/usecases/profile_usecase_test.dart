import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;
  late ProfileUseCase profileUseCase;
  late DriverDtoEntity driverDtoEntity;
  late VehicleDtoEntity vehicleDtoEntity;

  setUpAll(() {
    mockProfileRepository = MockProfileRepository();
    driverDtoEntity = DriverDtoEntity(firstName: "John", lastName: "Doe");
    vehicleDtoEntity = VehicleDtoEntity(id: "1", type: "car");
    profileUseCase = ProfileUseCase(
      profileRepository: mockProfileRepository,
    );
  });

  group("getProfile Tests", () {
    test("success case for getProfile in ProfileUseCase", () async {
      var mockResult = ApiSuccessResult<DriverDtoEntity>(data: driverDtoEntity);
      provideDummy<ApiResult<DriverDtoEntity>>(mockResult);

      // Arrange
      when(
        mockProfileRepository.getProfile(),
      ).thenAnswer((_) async => mockResult);

      // Act
      var result = await profileUseCase.getProfile();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverDtoEntity>>());
      var successResult = result as ApiSuccessResult<DriverDtoEntity>;
      expect(successResult.data.firstName, equals(driverDtoEntity.firstName));
      expect(successResult.data.lastName, equals(driverDtoEntity.lastName));

      verify(mockProfileRepository.getProfile()).called(1);
    });

    test("error case for getProfile in ProfileUseCase", () async {
      final errorResult = ApiErrorResult<DriverDtoEntity>(
        failure: Failure(errorMessage: "Generic error"),
      );

      // Arrange
      when(
        mockProfileRepository.getProfile(),
      ).thenAnswer((_) async => errorResult);

      // Act
      var result = await profileUseCase.getProfile();

      // Assert
      expect(result, isA<ApiErrorResult<DriverDtoEntity>>());
      var error = result as ApiErrorResult<DriverDtoEntity>;
      expect(error.failure, isA<Failure>());
      expect(error.failure.errorMessage, contains("Generic error"));

      verify(mockProfileRepository.getProfile()).called(1);
    });
  });

  group("getVehicle Tests", () {
    test("success case for getVehicle in ProfileUseCase", () async {
      var mockResult = ApiSuccessResult<VehicleDtoEntity>(
        data: vehicleDtoEntity,
      );
      provideDummy<ApiResult<VehicleDtoEntity>>(mockResult);

      // Arrange
      when(
        mockProfileRepository.getVehicle("car"),
      ).thenAnswer((_) async => mockResult);

      // Act
      var result = await profileUseCase.getVehicle("car");

      // Assert
      expect(result, isA<ApiSuccessResult<VehicleDtoEntity>>());
      var successResult = result as ApiSuccessResult<VehicleDtoEntity>;
      expect(successResult.data.id, equals(vehicleDtoEntity.id));
      expect(successResult.data.type, equals(vehicleDtoEntity.type));

      verify(mockProfileRepository.getVehicle("car")).called(1);
    });

    test("error case for getVehicle in ProfileUseCase", () async {
      final errorResult = ApiErrorResult<VehicleDtoEntity>(
        failure: Failure(errorMessage: "Vehicle not found"),
      );

      // Arrange
      when(
        mockProfileRepository.getVehicle("Car"),
      ).thenAnswer((_) async => errorResult);

      // Act
      var result = await profileUseCase.getVehicle("Car");

      // Assert
      expect(result, isA<ApiErrorResult<VehicleDtoEntity>>());
      var error = result as ApiErrorResult<VehicleDtoEntity>;
      expect(error.failure.errorMessage, contains("Vehicle not found"));

      verify(mockProfileRepository.getVehicle("Car")).called(1);
    });
  });
}
