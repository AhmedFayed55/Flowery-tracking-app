import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/save_order_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tab_view_model_test.mocks.dart';

@GenerateMocks([
  GetAllPendingOrdersUseCase,
  GetLoggedDriverDataUseCase,
  SaveOrderUseCase,
])
void main() {
  late GetAllPendingOrdersUseCase mockGetAllPendingOrdersUseCase;
  late GetLoggedDriverDataUseCase mockGetLoggedDriverDataUseCase;
  late SaveOrderUseCase mockSaveOrderUseCase;
  late HomeTabViewModel homeTabViewModel;
  late DriverDataEntity driverDataEntity;
  late OrdersEntity order1;
  late OrdersEntity order2;
  late GetPendingOrdersEntity pendingOrdersEntity;

  setUp(() {
    mockGetAllPendingOrdersUseCase = MockGetAllPendingOrdersUseCase();
    mockGetLoggedDriverDataUseCase = MockGetLoggedDriverDataUseCase();
    mockSaveOrderUseCase = MockSaveOrderUseCase();

    homeTabViewModel = HomeTabViewModel(
      mockGetAllPendingOrdersUseCase,
      mockSaveOrderUseCase,
      mockGetLoggedDriverDataUseCase,
    );

    driverDataEntity = DriverDataEntity(
      id: "D1",
      firstName: "Ahmed",
      lastName: "Fayed",
      email: "ahmed@example.com",
    );

    order1 = OrdersEntity(id: "O1", isDelivered: false);
    order2 = OrdersEntity(id: "O2", isDelivered: false);

    pendingOrdersEntity = GetPendingOrdersEntity(
      message: "Fetched successfully",
      orders: [order1, order2],
    );
  });

  group("HomeTabViewModel -> GetLoggedDriverDataEvent", () {
    test("success case should emit driver data", () async {
      var successResult = ApiSuccessResult<DriverDataEntity>(
        data: driverDataEntity,
      );
      provideDummy<ApiResult<DriverDataEntity>>(successResult);

      when(
        mockGetLoggedDriverDataUseCase.invoke(),
      ).thenAnswer((_) async => successResult);

      await homeTabViewModel.doIntent(GetLoggedDriverDataEvent());

      expect(homeTabViewModel.state.driverData, isNotNull);
      expect(
        homeTabViewModel.state.driverData!.firstName,
        driverDataEntity.firstName,
      );
      expect(
        homeTabViewModel.state.driverData!.lastName,
        driverDataEntity.lastName,
      );

      verify(mockGetLoggedDriverDataUseCase.invoke()).called(1);
    });

    test("error case should emit null driver data", () async {
      var errorResult = ApiErrorResult<DriverDataEntity>(
        failure: Failure(errorMessage: "Driver fetch failed"),
      );
      provideDummy<ApiResult<DriverDataEntity>>(errorResult);

      when(
        mockGetLoggedDriverDataUseCase.invoke(),
      ).thenAnswer((_) async => errorResult);

      await homeTabViewModel.doIntent(GetLoggedDriverDataEvent());

      verify(mockGetLoggedDriverDataUseCase.invoke()).called(1);

      expect(homeTabViewModel.state.driverData, isNull);
    });
  });

  group("HomeTabViewModel -> GetAllPendingOrdersEvent", () {
    test("success case should emit list of orders", () async {
      var successResult = ApiSuccessResult<GetPendingOrdersEntity>(
        data: pendingOrdersEntity,
      );
      provideDummy<ApiResult<GetPendingOrdersEntity>>(successResult);

      when(
        mockGetAllPendingOrdersUseCase.invoke(),
      ).thenAnswer((_) async => successResult);

      await homeTabViewModel.doIntent(GetAllPendingOrdersEvent());

      verify(mockGetAllPendingOrdersUseCase.invoke()).called(1);

      expect(homeTabViewModel.state.isLoadingGetOrders, false);
      expect(homeTabViewModel.state.errorGetOrders, isNull);
      expect(homeTabViewModel.state.orders.length, 2);
      expect(homeTabViewModel.state.orders.first.id, equals(order1.id));
    });

    test("error case should emit error message", () async {
      var errorResult = ApiErrorResult<GetPendingOrdersEntity>(
        failure: Failure(errorMessage: "Failed to fetch orders"),
      );
      provideDummy<ApiResult<GetPendingOrdersEntity>>(errorResult);

      when(
        mockGetAllPendingOrdersUseCase.invoke(),
      ).thenAnswer((_) async => errorResult);

      await homeTabViewModel.doIntent(GetAllPendingOrdersEvent());

      verify(mockGetAllPendingOrdersUseCase.invoke()).called(1);

      expect(homeTabViewModel.state.isLoadingGetOrders, false);
      expect(homeTabViewModel.state.orders, isEmpty);
      expect(
        homeTabViewModel.state.errorGetOrders,
        errorResult.failure.errorMessage,
      );
    });
  });

  group("HomeTabViewModel -> RejectOrderEvent", () {
    test("should remove order from state.orders", () async {
      homeTabViewModel.emit(
        homeTabViewModel.state.copyWith(orders: [order1, order2]),
      );

      await homeTabViewModel.doIntent(RejectOrderEvent(order1.id!));

      expect(homeTabViewModel.state.orders.length, 1);
      expect(homeTabViewModel.state.orders.first.id, order2.id);
    });
  });
}
