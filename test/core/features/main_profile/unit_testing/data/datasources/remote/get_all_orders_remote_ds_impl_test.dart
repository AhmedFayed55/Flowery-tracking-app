import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/orders_page/data/datasources/remote/get_all_orders_remote_ds_impl.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/metadata_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_all_orders_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late String message;
  late MockApiServices mockApiServices;
  late GetAllOrdersRemoteDataSourceImpl getAllOrdersRemoteDataSourceImpl;
  late GetAllOrdersResponse getAllOrdersResponse;
  late MetadataDto metadataDto;

  setUp(() {
    message = "message";
    mockApiServices = MockApiServices();
    getAllOrdersRemoteDataSourceImpl = GetAllOrdersRemoteDataSourceImpl(
      apiServices: mockApiServices,
    );
    metadataDto = MetadataDto(currentPage: 1);

    getAllOrdersResponse = GetAllOrdersResponse(
      message: message,
      metadata: metadataDto,
    );
  });

  group("Test GetAllOrdersRemoteDataSourceImpl in Data_Layer", () {
    test(
      "success case for getAllDriverOrders returns GetAllOrdersResponse",
      () async {
        // Arrange
        when(
          mockApiServices.getAllDriverOrders(),
        ).thenAnswer((_) async => getAllOrdersResponse);

        // Act
        final result = await getAllOrdersRemoteDataSourceImpl
            .getAllDriverOrders();

        // Assert
        expect(result, isA<GetAllOrdersResponse>());
        expect(result.message, equals(getAllOrdersResponse.message));
        expect(
          result.metadata?.currentPage,
          equals(getAllOrdersResponse.metadata?.currentPage),
        );

        verify(mockApiServices.getAllDriverOrders()).called(1);
      },
    );
  });
}
