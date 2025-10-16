import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds_impl.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/logged_driver_data.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../core/features/login/unit_testing/data/datasources/remote/login_remote_ds_impl_test.mocks.dart';


@GenerateMocks([ApiServices])
void main() {
  late ApiServices mockApiServices;
  late HomeTabRemoteDataSourceImpl homeTabRemoteDataSourceImpl;
  late GetPendingOrdersDto getPendingOrdersDto;
  late LoggedDriverDto loggedDriverDto;

  setUpAll(() {
    mockApiServices = MockApiServices();
    homeTabRemoteDataSourceImpl = HomeTabRemoteDataSourceImpl(mockApiServices);

    getPendingOrdersDto = GetPendingOrdersDto(
      message: "Success",
      metadata: null,
      orders: [],
    );

    loggedDriverDto = LoggedDriverDto(
      message: "Driver data retrieved successfully",
      driver: DriverDataDto(
        id: "D1",
        firstName: "Ahmed",
        lastName: "Fayed",
        email: "driver@example.com",
      ),
    );
  });

  group("Test HomeTabRemoteDataSourceImpl in Data_Layer", () {
    test("success case for getAllPendingOrders returns GetPendingOrdersDto", () async {
      when(mockApiServices.getAllPendingOrders())
          .thenAnswer((_) async => getPendingOrdersDto);

      var result = await homeTabRemoteDataSourceImpl.getAllPendingOrders();

      verify(mockApiServices.getAllPendingOrders()).called(1);

      expect(result, isA<GetPendingOrdersDto>());
      expect(result.message, equals(getPendingOrdersDto.message));
      expect(result.orders, equals(getPendingOrdersDto.orders));
      expect(result.metadata, equals(getPendingOrdersDto.metadata));

    });

    test("success case for getLoggedDriverData returns LoggedDriverDto", () async {
      when(mockApiServices.getDriverData())
          .thenAnswer((_) async => loggedDriverDto);

      var result = await homeTabRemoteDataSourceImpl.getLoggedDriverData();

      verify(mockApiServices.getDriverData()).called(1);

      expect(result, isA<LoggedDriverDto>());
      expect(result.message, equals(loggedDriverDto.message));
      expect(result.driver?.id, equals(loggedDriverDto.driver?.id));
      expect(result.driver?.firstName, equals(loggedDriverDto.driver?.firstName));
      expect(result.driver?.email, equals(loggedDriverDto.driver?.email));

    });
  });
}
