import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_order_firebase_usecase.dart';

import 'update_order_firebase_usecase_test.mocks.dart';

@GenerateMocks([OrderDetailsRepo])
void main() {
  late UpdateOrderFirebaseUsecase usecase;
  late MockOrderDetailsRepo mockRepo;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    usecase = UpdateOrderFirebaseUsecase(mockRepo);
  });

  const orderId = 'order_123';
  const status = RiderOrderStatus.delivered;

  provideDummy<FirebaseResult>(FirebaseSuccessResult<void>(data: null));

  test(
    ' should return FirebaseSuccessResult when repo returns success',
    () async {
      // arrange
      when(
        mockRepo.updateOrderStatusFirebase(orderId, status),
      ).thenAnswer((_) async => FirebaseSuccessResult<void>(data: null));

      // act
      final result = await usecase.invoke(orderId, status);

      // assert
      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(mockRepo.updateOrderStatusFirebase(orderId, status)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    ' should return FirebaseErrorResult when repo returns failure',
    () async {
      // arrange
      const errorMessage = 'Failed to update order status';
      when(mockRepo.updateOrderStatusFirebase(orderId, status)).thenAnswer(
        (_) async => FirebaseErrorResult<void>(
          failure: Failure(errorMessage: errorMessage),
        ),
      );

      // act
      final result = await usecase.invoke(orderId, status);

      // assert
      expect(result, isA<FirebaseErrorResult<void>>());
      expect(
        (result as FirebaseErrorResult).failure.errorMessage,
        errorMessage,
      );
      verify(mockRepo.updateOrderStatusFirebase(orderId, status)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
