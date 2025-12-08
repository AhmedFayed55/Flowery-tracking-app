import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/repositories/home_tab_repo_impl.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/logged_driver_data.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tab_repo_impl_test.mocks.dart';

@GenerateMocks([HomeTabRemoteDataSource, HomeTabFirebaseDataSource])
void main() {
  late HomeTabRemoteDataSource mockRemoteDataSource;
  late HomeTabFirebaseDataSource mockFirebaseDataSource;
  late HomeTabRepoImpl homeTabRepoImpl;

  setUpAll(() {
    mockRemoteDataSource = MockHomeTabRemoteDataSource();
    mockFirebaseDataSource = MockHomeTabFirebaseDataSource();
    homeTabRepoImpl = HomeTabRepoImpl(
      mockRemoteDataSource,
      mockFirebaseDataSource,
    );
  });

  group("getLoggedDriverData", () {
    late DriverDataDto driverDto;
    late LoggedDriverDto loggedDriverDto;

    setUp(() {
      driverDto = DriverDataDto(firstName: "Ahmed", lastName: "Mousa");
      loggedDriverDto = LoggedDriverDto(driver: driverDto);
    });

    test(
      "success case for getLoggedDriverData with ApiSuccessResult",
      () async {
        when(
          mockRemoteDataSource.getLoggedDriverData(),
        ).thenAnswer((_) async => loggedDriverDto);

        var result = await homeTabRepoImpl.getLoggedDriverData();

        verify(mockRemoteDataSource.getLoggedDriverData()).called(1);

        expect(result, isA<ApiSuccessResult<DriverDataEntity>>());
        final success = result as ApiSuccessResult<DriverDataEntity>;
        expect(success.data.firstName, equals(driverDto.firstName));
        expect(success.data.lastName, equals(driverDto.lastName));
      },
    );

    test("Error case for getLoggedDriverData with DioException", () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: "/getLoggedDriverData"),
        type: DioExceptionType.connectionTimeout,
      );
      when(mockRemoteDataSource.getLoggedDriverData()).thenThrow(dioError);

      var result = await homeTabRepoImpl.getLoggedDriverData();

      verify(mockRemoteDataSource.getLoggedDriverData()).called(1);

      expect(result, isA<ApiErrorResult<DriverDataEntity>>());
      final error = result as ApiErrorResult<DriverDataEntity>;
      expect(error.failure, isA<ServerFailure>());
    });

    test("Error case for getLoggedDriverData with generic Exception", () async {
      when(
        mockRemoteDataSource.getLoggedDriverData(),
      ).thenThrow(Exception("Error"));

      var result = await homeTabRepoImpl.getLoggedDriverData();

      verify(mockRemoteDataSource.getLoggedDriverData()).called(1);

      expect(result, isA<ApiErrorResult<DriverDataEntity>>());
      final error = result as ApiErrorResult<DriverDataEntity>;
      expect(error.failure.errorMessage, contains("Error"));
    });
  });
}
