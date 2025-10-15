import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/repositories/get_all_orders_repo.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/usecases/get_all_orders_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_orders_usecase_test.mocks.dart';

@GenerateMocks([GetAllOrdersRepo])
void main() {
  late MockGetAllOrdersRepo mockGetAllOrdersRepo;
  late GetAllOrdersUseCase getAllOrdersUseCase;
  late GetAllOrdersEntity getAllOrdersEntity;
  late String message;

  setUp(() {
    message = "message";
    mockGetAllOrdersRepo = MockGetAllOrdersRepo();
    getAllOrdersUseCase = GetAllOrdersUseCase(
      getAllOrdersRepo: mockGetAllOrdersRepo,
    );
    getAllOrdersEntity = GetAllOrdersEntity(message: message);
  });

  group("GetAllOrdersUseCase Tests in Domain_Layer", () {
    test("success case for getAllDriverOrders", () async {
      // Arrange
      var mockResult = ApiSuccessResult<GetAllOrdersEntity>(
        data: getAllOrdersEntity,
      );
      provideDummy<ApiResult<GetAllOrdersEntity>>(mockResult);

      when(
        mockGetAllOrdersRepo.getAllDriverOrders(),
      ).thenAnswer((_) async => mockResult);

      // Act
      var result = await getAllOrdersUseCase.getAllDriverOrders();

      // Assert
      expect(result, isA<ApiSuccessResult<GetAllOrdersEntity>>());
      var successResult = result as ApiSuccessResult<GetAllOrdersEntity>;
      expect(successResult.data.message, equals(getAllOrdersEntity.message));

      verify(mockGetAllOrdersRepo.getAllDriverOrders()).called(1);
    });
  });
}
