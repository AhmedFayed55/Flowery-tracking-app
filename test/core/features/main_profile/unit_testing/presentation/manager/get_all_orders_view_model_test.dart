import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/metadata_dto_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/usecases/get_all_orders_usecase.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_event.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_view_model.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_orders_view_model_test.mocks.dart';

@GenerateMocks([GetAllOrdersUseCase])
void main() {
  late MockGetAllOrdersUseCase mockGetAllOrdersUseCase;
  late GetAllOrdersCubit getAllOrdersCubit;
  late GetAllOrdersEntity getAllOrdersEntity;
  late MetadataDtoEntity metadataDtoEntity;
  late String message;

  setUp(() {
    message = "message";
    metadataDtoEntity = MetadataDtoEntity(currentPage: 1);
    mockGetAllOrdersUseCase = MockGetAllOrdersUseCase();
    getAllOrdersCubit = GetAllOrdersCubit(
      getAllOrdersUseCase: mockGetAllOrdersUseCase,
    );
    getAllOrdersEntity = GetAllOrdersEntity(
      message: message,
      metadataDtoEntity: metadataDtoEntity,
    );
  });

  group("GetAllOrdersCubit doIntent -> GetAllOrdersEvent", () {
    test("emit success state with getAllDriverOrders", () async {
      // Arrange
      var successResult = ApiSuccessResult<GetAllOrdersEntity>(
        data: getAllOrdersEntity,
      );
      provideDummy<ApiResult<GetAllOrdersEntity>>(successResult);

      when(
        mockGetAllOrdersUseCase.getAllDriverOrders(),
      ).thenAnswer((_) async => successResult);

      // Act
      await getAllOrdersCubit.doIntent(GetAllOrdersEvent());

      // Assert
      expect(getAllOrdersCubit.state.isLoading, false);
      expect(getAllOrdersCubit.state.isSuccess, true);
      expect(getAllOrdersCubit.state.isError, false);
      expect(getAllOrdersCubit.state.getAllOrdersEntity, getAllOrdersEntity);

      verify(mockGetAllOrdersUseCase.getAllDriverOrders()).called(1);
    });

    test("emit error state with getAllDriverOrders", () async {
      // Arrange
      var errorResult = ApiErrorResult<GetAllOrdersEntity>(
        failure: Failure(errorMessage: "Error fetching orders"),
      );
      provideDummy<ApiResult<GetAllOrdersEntity>>(errorResult);

      when(
        mockGetAllOrdersUseCase.getAllDriverOrders(),
      ).thenAnswer((_) async => errorResult);

      // Act
      await getAllOrdersCubit.doIntent(GetAllOrdersEvent());

      // Assert
      expect(getAllOrdersCubit.state.isLoading, false);
      expect(getAllOrdersCubit.state.isSuccess, false);
      expect(getAllOrdersCubit.state.isError, true);
      expect(getAllOrdersCubit.state.getAllOrdersEntity, isNull);

      verify(mockGetAllOrdersUseCase.getAllDriverOrders()).called(1);
    });
  });
}
