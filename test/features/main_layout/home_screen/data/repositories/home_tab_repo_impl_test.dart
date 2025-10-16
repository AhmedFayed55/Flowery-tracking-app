import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/repositories/home_tab_repo_impl.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/logged_driver_data.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
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
  late GetPendingOrdersDto getPendingOrdersDto;

  setUpAll(() {
    mockRemoteDataSource = MockHomeTabRemoteDataSource();
    mockFirebaseDataSource = MockHomeTabFirebaseDataSource();
    homeTabRepoImpl = HomeTabRepoImpl(
      mockRemoteDataSource,
      mockFirebaseDataSource,
    );

    getPendingOrdersDto = GetPendingOrdersDto(message: "Success");
  });

  group("getAllPendingOrders", () {
    test(
      "success case for getAllPendingOrders with ApiSuccessResult",
      () async {
        when(
          mockRemoteDataSource.getAllPendingOrders(),
        ).thenAnswer((_) async => getPendingOrdersDto);

        var result = await homeTabRepoImpl.getAllPendingOrders();

        verify(mockRemoteDataSource.getAllPendingOrders()).called(1);

        expect(result, isA<ApiSuccessResult<GetPendingOrdersEntity>>());
        var success = result as ApiSuccessResult<GetPendingOrdersEntity>;
        expect(success.data.message, equals(getPendingOrdersDto.message));
      },
    );

    test("Error case for getAllPendingOrders with DioException", () async {
      final dioError = DioException(requestOptions: RequestOptions());
      when(mockRemoteDataSource.getAllPendingOrders()).thenThrow(dioError);

      var result = await homeTabRepoImpl.getAllPendingOrders();

      verify(mockRemoteDataSource.getAllPendingOrders()).called(1);

      expect(result, isA<ApiErrorResult<GetPendingOrdersEntity>>());
      var error = result as ApiErrorResult<GetPendingOrdersEntity>;
      expect(error.failure, isA<ServerFailure>());
    });

    test("Error case for getAllPendingOrders with generic Exception", () async {
      when(
        mockRemoteDataSource.getAllPendingOrders(),
      ).thenThrow(Exception("Unexpected error"));

      var result = await homeTabRepoImpl.getAllPendingOrders();

      verify(mockRemoteDataSource.getAllPendingOrders()).called(1);

      expect(result, isA<ApiErrorResult<GetPendingOrdersEntity>>());
      var error = result as ApiErrorResult<GetPendingOrdersEntity>;
      expect(error.failure.errorMessage, contains("Unexpected error"));
    });
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
