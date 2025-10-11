import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/features/order_details/domin/repo/order_details_repo.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_driver_location_usecase.dart';

import 'update_driver_location_usecase_test.mocks.dart';

@GenerateMocks([OrderDetailsRepo])
void main() {
  late UpdateDriverLocationUsecase usecase;
  late MockOrderDetailsRepo mockRepo;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    usecase = UpdateDriverLocationUsecase(mockRepo);
  });

  const orderId = 'order_123';
  const location = '30.0444,31.2357';

  provideDummy<FirebaseResult>(FirebaseSuccessResult<void>(data: null));

  test(
    ' should return FirebaseSuccessResult when repo returns success',
    () async {
      // arrange
      when(
        mockRepo.updateDriverLocation(orderId, location),
      ).thenAnswer((_) async => FirebaseSuccessResult<void>(data: null));

      // act
      final result = await usecase.invoke(orderId, location);

      // assert
      expect(result, isA<FirebaseSuccessResult<void>>());
      verify(mockRepo.updateDriverLocation(orderId, location)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );

  test(
    ' should return FirebaseErrorResult when repo returns failure',
    () async {
      // arrange
      const errorMessage = 'Failed to update driver location';
      when(mockRepo.updateDriverLocation(orderId, location)).thenAnswer(
        (_) async => FirebaseErrorResult<void>(
          failure: Failure(errorMessage: errorMessage),
        ),
      );

      // act
      final result = await usecase.invoke(orderId, location);

      // assert
      expect(result, isA<FirebaseErrorResult<void>>());
      expect(
        (result as FirebaseErrorResult).failure.errorMessage,
        errorMessage,
      );
      verify(mockRepo.updateDriverLocation(orderId, location)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
