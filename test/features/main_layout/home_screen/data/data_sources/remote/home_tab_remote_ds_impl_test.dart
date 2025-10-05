import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/remote/home_tab_remote_ds_impl.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/orders_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tab_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late HomeTabRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = HomeTabRemoteDataSourceImpl(mockApiServices);
  });

  test(
    'verify when call getAllPendingOrders it should call getAllPendingOrders from ApiServices',
        () async {
      final expectedResponse = GetPendingOrdersDto(
        message: "Success",
        orders: [
          OrdersDto(id: "15415"),
          OrdersDto(id: "15513"),
        ],
      );

      when(mockApiServices.getAllPendingOrders())
          .thenAnswer((_) async => expectedResponse);

      final result = await dataSource.getAllPendingOrders();

      verify(mockApiServices.getAllPendingOrders()).called(1);
      expect(result, isA<GetPendingOrdersDto>());
      expect(result.orders!.length, expectedResponse.orders!.length);
      expect(result.message, equals(expectedResponse.message));
    },
  );
}