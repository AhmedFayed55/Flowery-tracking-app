import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/local/profile_local_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
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

  setUpAll(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    mockProfileLocalDataSource = MockProfileLocalDataSource();
    profileRepositoryImpl = ProfileRepositoryImpl(
      profileRemoteDataSource: mockProfileRemoteDataSource,
      profileLocalDataSource: mockProfileLocalDataSource,
    );

    driverDto = DriverDto(
      firstName: "John",
      lastName: "Doe",
    );

    driverDtoEntity = driverDto.toEntity();
  });

  group("Test ProfileRepositoryImpl", () {
    test("success case for getProfile with ApiSuccessResult", () async {
      // Arrange
      when(mockProfileRemoteDataSource.getProfile())
          .thenAnswer((_) async => driverDto);

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
      final dioException = DioException(requestOptions: RequestOptions(path: ''));
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
  });
}
