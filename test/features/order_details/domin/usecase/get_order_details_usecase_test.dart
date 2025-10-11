import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/get_order_details_usecase.dart';

import 'get_order_details_usecase_test.mocks.dart';

@GenerateMocks([OrderDetailsRepo])
void main() {
  late GetOrderDetailsUsecase usecase;
  late MockOrderDetailsRepo mockRepo;

  const orderId = 'order_123';
  final mockOrderEntity = OrdersEntity(
    id: orderId,
    totalPrice: 100,
    state: 'pending',
    createdAt: DateTime(2025, 10, 10).toString(),
  );

  provideDummy<FirebaseResult<OrdersEntity>>(
    FirebaseSuccessResult<OrdersEntity>(
      data: OrdersEntity(
        id: 'dummy',
        totalPrice: 0,
        state: 'dummy',
        createdAt: '',
      ),
    ),
  );

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    usecase = GetOrderDetailsUsecase(mockRepo);
  });

  test(
    ' should return FirebaseResult.success when repo returns success',
    () async {
      // arrange
      when(mockRepo.getOrderDetails(orderId)).thenAnswer(
        (_) async => FirebaseSuccessResult<OrdersEntity>(data: mockOrderEntity),
      );

      // act
      final result = await usecase.invoke(orderId);
      result as FirebaseSuccessResult<OrdersEntity>;

      // assert
      expect(result, isA<FirebaseSuccessResult<OrdersEntity>>());
      expect(result.data.id, orderId);
      verify(mockRepo.getOrderDetails(orderId)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    ' should return FirebaseResult.failure when repo returns failure',
    () async {
      // arrange
      const errorMessage = 'Order not found';
      when(mockRepo.getOrderDetails(orderId)).thenAnswer(
        (_) async => FirebaseErrorResult<OrdersEntity>(
          failure: Failure(errorMessage: errorMessage),
        ),
      );

      // act
      final result = await usecase.invoke(orderId);
      result as FirebaseErrorResult<OrdersEntity>;

      // assert
      expect(result, isA<FirebaseErrorResult<OrdersEntity>>());
      expect(result.failure.errorMessage, errorMessage);
      verify(mockRepo.getOrderDetails(orderId)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
