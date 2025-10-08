import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/local/profile_local_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource, ProfileLocalDataSource])
void main() {
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;
  late MockProfileLocalDataSource mockProfileLocalDataSource;
  late ProfileRepositoryImpl profileRepositoryImpl;
  late DriverDto driverDto;
  late DriverDtoEntity driverDtoEntity;
  late VehicleDto vehicleDto;
  late VehicleDtoEntity vehicleDtoEntity;

  setUpAll(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    mockProfileLocalDataSource = MockProfileLocalDataSource();
    profileRepositoryImpl = ProfileRepositoryImpl(
      profileRemoteDataSource: mockProfileRemoteDataSource,
      profileLocalDataSource: mockProfileLocalDataSource,
    );

    driverDto = DriverDto(firstName: "John", lastName: "Doe");
    driverDtoEntity = driverDto.toEntity();

    vehicleDto = VehicleDto(id: "1", type: "Car");
    vehicleDtoEntity = vehicleDto.toEntity();
  });

  group("Test ProfileRepositoryImpl", () {
    test("success case for getProfile with ApiSuccessResult", () async {
      // Arrange
      when(
        mockProfileRemoteDataSource.getProfile(),
      ).thenAnswer((_) async => driverDto);

      // Act
      var result = await profileRepositoryImpl.getProfile();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverDtoEntity>>());
      var successResult = result as ApiSuccessResult<DriverDtoEntity>;
      expect(successResult.data.firstName, equals(driverDtoEntity.firstName));
      expect(successResult.data.lastName, equals(driverDtoEntity.lastName));

      verify(mockProfileRemoteDataSource.getProfile()).called(1);
    });

    test("Error case for getProfile with DioException", () async {
      final dioException = DioException(requestOptions: RequestOptions());
      when(mockProfileRemoteDataSource.getProfile()).thenThrow(dioException);

      // Act
      var result = await profileRepositoryImpl.getProfile();

      // Assert
      expect(result, isA<ApiErrorResult<DriverDtoEntity>>());
      var errorResult = result as ApiErrorResult<DriverDtoEntity>;
      expect(errorResult.failure, isA<ServerFailure>());

      verify(mockProfileRemoteDataSource.getProfile()).called(1);
    });

    test("Error case for getProfile with generic Exception", () async {
      final exception = Exception("Generic error");
      when(mockProfileRemoteDataSource.getProfile()).thenThrow(exception);

      // Act
      var result = await profileRepositoryImpl.getProfile();

      // Assert
      expect(result, isA<ApiErrorResult<DriverDtoEntity>>());
      var errorResult = result as ApiErrorResult<DriverDtoEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure.errorMessage, contains("Generic error"));

      verify(mockProfileRemoteDataSource.getProfile()).called(1);
    });

    // ------>>>  getVehicle Tests  <<<------

    test("success case for getVehicle with ApiSuccessResult", () async {
      // Arrange
      when(
        mockProfileRemoteDataSource.getVehicle("1"),
      ).thenAnswer((_) async => vehicleDto);

      // Act
      var result = await profileRepositoryImpl.getVehicle("1");

      // Assert
      expect(result, isA<ApiSuccessResult<VehicleDtoEntity>>());
      var successResult = result as ApiSuccessResult<VehicleDtoEntity>;
      expect(successResult.data.id, equals(vehicleDtoEntity.id));
      expect(successResult.data.type, equals(vehicleDtoEntity.type));
      expect(successResult.data.image, equals(vehicleDtoEntity.image));

      verify(mockProfileRemoteDataSource.getVehicle("1")).called(1);
    });

    test("Error case for getVehicle with DioException", () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
      );
      when(mockProfileRemoteDataSource.getVehicle("1")).thenThrow(dioException);

      // Act
      var result = await profileRepositoryImpl.getVehicle("1");

      // Assert
      expect(result, isA<ApiErrorResult<VehicleDtoEntity>>());
      var errorResult = result as ApiErrorResult<VehicleDtoEntity>;
      expect(errorResult.failure, isA<ServerFailure>());

      verify(mockProfileRemoteDataSource.getVehicle("1")).called(1);
    });

    test("Error case for getVehicle with generic Exception", () async {
      final exception = Exception("Generic error");
      when(mockProfileRemoteDataSource.getVehicle("1")).thenThrow(exception);

      // Act
      var result = await profileRepositoryImpl.getVehicle("1");

      // Assert
      expect(result, isA<ApiErrorResult<VehicleDtoEntity>>());
      var errorResult = result as ApiErrorResult<VehicleDtoEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure.errorMessage, contains("Generic error"));

      verify(mockProfileRemoteDataSource.getVehicle("1")).called(1);
    });
  });
}
