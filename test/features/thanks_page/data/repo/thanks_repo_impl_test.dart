import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/thanks_page/data/repo/thanks_repo_impl.dart';
import 'package:flowery_tracking_app/features/thanks_page/data/sources/thanks_ds.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'thanks_repo_impl_test.mocks.dart';

@GenerateMocks([ThanksDs, InternetConnectionChecker])
void main() {
  late ThanksRepoImpl repo;
  late MockThanksDs mockThanksDs;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockThanksDs = MockThanksDs();
    mockConnectionChecker = MockInternetConnectionChecker();
    repo = ThanksRepoImpl(mockThanksDs, mockConnectionChecker);
  });

  group('ThanksRepoImpl', () {
    const orderId = '123';
    const orderStatus = OrderStatus.completed;

    test(' returns ApiErrorResult when there is no internet', () async {
      // Arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => false);

      // Act
      final result = await repo.updateOrderStatusApi(orderId, orderStatus);

      // Assert
      expect(result, isA<ApiErrorResult>());
      final error = result as ApiErrorResult;
      expect(error.failure.errorMessage, AppConstants.noInternet);
      verifyNever(mockThanksDs.updateOrderStatusApi(any, any));
    });

    test(' calls updateOrderStatusApi when connected to internet', () async {
      // Arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);

      when(mockThanksDs.updateOrderStatusApi(orderId, orderStatus))
          .thenAnswer((_) async =>  ApiSuccessResult(data: 'Success'));

      // Act
      final result = await repo.updateOrderStatusApi(orderId, orderStatus);

      // Assert
      expect(result, isA<ApiSuccessResult>());
      verify(mockThanksDs.updateOrderStatusApi(orderId, orderStatus)).called(1);
    });

    test(' calls deleteOrderLocal successfully', () async {
      // Arrange
      when(mockThanksDs.deleteOrderLocal()).thenAnswer((_) async {});

      // Act
      await repo.deleteOrderLocal();

      // Assert
      verify(mockThanksDs.deleteOrderLocal()).called(1);
    });
  });
}
