import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/thanks_page/data/sources/thanks_ds_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'thanks_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices, SharedPrefHelper])
void main() {
  late ThanksDsImpl thanksDs;
  late MockApiServices mockApiServices;
  late MockSharedPrefHelper mockSharedPrefHelper;

  setUp(() {
    mockApiServices = MockApiServices();
    mockSharedPrefHelper = MockSharedPrefHelper();
    thanksDs = ThanksDsImpl(mockApiServices, mockSharedPrefHelper);
  });

  group('ThanksDsImpl', () {
    const orderId = '123';
    const orderStatus = OrderStatus.completed;

    test(
      ' calls ApiServices.updateOrderStatusApi with correct parameters',
      () async {
        // Arrange
        when(
          mockApiServices.updateOrderStatusApi(any, any),
        ).thenAnswer((_) async => Future.value());

        // Act
        await thanksDs.updateOrderStatusApi(orderId, orderStatus);

        // Assert
        verify(
          mockApiServices.updateOrderStatusApi(orderId, {
            ApiConstants.state: orderStatus.statusText,
          }),
        ).called(1);
      },
    );

    test(' calls SharedPrefHelper.removeData with correct key', () async {
      // Arrange
      when(
        mockSharedPrefHelper.removeData(key: anyNamed('key')),
      ).thenAnswer((_) async => Future.value(true));

      // Act
      await thanksDs.deleteOrderLocal();

      // Assert
      verify(
        mockSharedPrefHelper.removeData(key: AppConstants.orderId),
      ).called(1);
    });
  });
}
