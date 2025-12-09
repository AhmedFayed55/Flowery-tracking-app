import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_pending_orders_use_case_test.mocks.dart';

@GenerateMocks([HomeTabRepo])
void main() {
  late HomeTabRepo mockHomeTabRepo;
  late GetAllPendingOrdersUseCase getAllPendingOrdersUseCase;
  late GetPendingOrdersEntity entity;

  setUpAll(() {
    mockHomeTabRepo = MockHomeTabRepo();
    getAllPendingOrdersUseCase = GetAllPendingOrdersUseCase(mockHomeTabRepo);
    entity = GetPendingOrdersEntity(orders: []);
  });

  group("GetAllPendingOrdersUseCase Tests", () {
    test("success case - should return ApiSuccessResult", () async {
      var mockResult = ApiSuccessResult<GetPendingOrdersEntity>(data: entity);
      provideDummy<ApiResult<GetPendingOrdersEntity>>(mockResult);

      when(
        mockHomeTabRepo.getAllPendingOrders(page: 1),
      ).thenAnswer((_) async => mockResult);

      var result = await getAllPendingOrdersUseCase.invoke(page: 1);

      verify(mockHomeTabRepo.getAllPendingOrders(page: 1)).called(1);

      expect(result, isA<ApiSuccessResult<GetPendingOrdersEntity>>());
      var success = result as ApiSuccessResult<GetPendingOrdersEntity>;
      expect(success.data, equals(entity));
    });

    test("error case - should return ApiErrorResult", () async {
      var errorResult = ApiErrorResult<GetPendingOrdersEntity>(
        failure: Failure(errorMessage: "Server error"),
      );
      provideDummy<ApiResult<GetPendingOrdersEntity>>(errorResult);

      when(
        mockHomeTabRepo.getAllPendingOrders(page: 1),
      ).thenAnswer((_) async => errorResult);

      var result = await getAllPendingOrdersUseCase.invoke(page: 1);

      verify(mockHomeTabRepo.getAllPendingOrders(page: 1)).called(1);

      expect(result, isA<ApiErrorResult<GetPendingOrdersEntity>>());
      var error = result as ApiErrorResult<GetPendingOrdersEntity>;
      expect(error.failure.errorMessage, contains("Server error"));
    });
  });
}
