import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_pending_orders_use_case_test.mocks.dart';

@GenerateMocks([HomeTabRepo])
void main() {
  late HomeTabRepo mockHomeTabRepo;
  late GetLoggedDriverDataUseCase getLoggedDriverDataUseCase;
  late DriverDataEntity driverDataEntity;

  setUpAll(() {
    mockHomeTabRepo = MockHomeTabRepo();
    getLoggedDriverDataUseCase = GetLoggedDriverDataUseCase(mockHomeTabRepo);
    driverDataEntity = DriverDataEntity(id: "9856", email: "ahmed@yahoo.com");
  });

  group("GetLoggedDriverDataUseCase Tests", () {
    test("success case - should return ApiSuccessResult", () async {
      var mockResult = ApiSuccessResult<DriverDataEntity>(
        data: driverDataEntity,
      );
      provideDummy<ApiResult<DriverDataEntity>>(mockResult);

      when(
        mockHomeTabRepo.getLoggedDriverData(),
      ).thenAnswer((_) async => mockResult);

      var result = await getLoggedDriverDataUseCase.invoke();

      verify(mockHomeTabRepo.getLoggedDriverData()).called(1);

      expect(result, isA<ApiSuccessResult<DriverDataEntity>>());
      var success = result as ApiSuccessResult<DriverDataEntity>;
      expect(success.data.id, equals(driverDataEntity.id));
      expect(success.data.email, equals(driverDataEntity.email));
    });

    test("error case - should return ApiErrorResult", () async {
      var errorResult = ApiErrorResult<DriverDataEntity>(
        failure: Failure(errorMessage: "Unauthorized access"),
      );
      provideDummy<ApiResult<DriverDataEntity>>(errorResult);

      when(
        mockHomeTabRepo.getLoggedDriverData(),
      ).thenAnswer((_) async => errorResult);

      var result = await getLoggedDriverDataUseCase.invoke();

      verify(mockHomeTabRepo.getLoggedDriverData()).called(1);

      expect(result, isA<ApiErrorResult<DriverDataEntity>>());
      var error = result as ApiErrorResult<DriverDataEntity>;
      expect(error.failure.errorMessage, contains("Unauthorized access"));
    });
  });
}
