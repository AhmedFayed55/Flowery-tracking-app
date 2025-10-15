import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/orders_page/data/datasources/remote/get_all_orders_remote_ds.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/metadata_dto.dart';
import 'package:flowery_tracking_app/features/orders_page/data/models/response/get_all_orders_response.dart';
import 'package:flowery_tracking_app/features/orders_page/data/repositories_impl/get_all_orders_repo_impl.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_orders_repo_impl_test.mocks.dart';

@GenerateMocks([GetAllOrdersRemoteDataSource])
void main() {
  late String message;
  late MockGetAllOrdersRemoteDataSource mockGetAllOrdersRemoteDataSource;
  late GetAllOrdersRepoImpl getAllOrdersRepoImpl;
  late GetAllOrdersResponse getAllOrdersResponse;
  late GetAllOrdersEntity getAllOrdersEntity;
  late MetadataDto metadataDto;

  setUp(() {
    message = "message";
    mockGetAllOrdersRemoteDataSource = MockGetAllOrdersRemoteDataSource();
    getAllOrdersRepoImpl = GetAllOrdersRepoImpl(
      getAllOrdersRemoteDataSource: mockGetAllOrdersRemoteDataSource,
    );

    metadataDto = MetadataDto(currentPage: 1);
    getAllOrdersResponse = GetAllOrdersResponse(
      message: message,
      metadata: metadataDto,
    );
    getAllOrdersEntity = getAllOrdersResponse.toEntity();
  });

  group("Test GetAllOrdersRepoImpl in Data_Layer", () {
    test("success case for getAllDriverOrders with ApiSuccessResult", () async {
      // Arrange
      when(
        mockGetAllOrdersRemoteDataSource.getAllDriverOrders(),
      ).thenAnswer((_) async => getAllOrdersResponse);

      // Act
      var result = await getAllOrdersRepoImpl.getAllDriverOrders();

      // Assert
      expect(result, isA<ApiSuccessResult<GetAllOrdersEntity>>());
      var successResult = result as ApiSuccessResult<GetAllOrdersEntity>;
      expect(successResult.data.message, equals(getAllOrdersEntity.message));
      expect(
        successResult.data.metadataDtoEntity?.currentPage,
        equals(getAllOrdersEntity.metadataDtoEntity?.currentPage),
      );

      verify(mockGetAllOrdersRemoteDataSource.getAllDriverOrders()).called(1);
    });

    test("Error case for getAllDriverOrders with DioException", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(),
      );
      when(
        mockGetAllOrdersRemoteDataSource.getAllDriverOrders(),
      ).thenThrow(dioException);

      // Act
      var result = await getAllOrdersRepoImpl.getAllDriverOrders();

      // Assert
      expect(result, isA<ApiErrorResult<GetAllOrdersEntity>>());
      var errorResult = result as ApiErrorResult<GetAllOrdersEntity>;
      expect(errorResult.failure, isA<ServerFailure>());

      verify(mockGetAllOrdersRemoteDataSource.getAllDriverOrders()).called(1);
    });

    test("Error case for getAllDriverOrders with generic Exception", () async {
      // Arrange
      String errorMessage = "errorMessage";
      final exception = Exception(errorMessage);
      when(
        mockGetAllOrdersRemoteDataSource.getAllDriverOrders(),
      ).thenThrow(exception);

      // Act
      var result = await getAllOrdersRepoImpl.getAllDriverOrders();

      // Assert
      expect(result, isA<ApiErrorResult<GetAllOrdersEntity>>());
      var errorResult = result as ApiErrorResult<GetAllOrdersEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure.errorMessage, contains(errorMessage));

      verify(mockGetAllOrdersRemoteDataSource.getAllDriverOrders()).called(1);
    });

  });
}
