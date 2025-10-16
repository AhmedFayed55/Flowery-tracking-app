import 'package:flowery_tracking_app/core/services/firebase_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/data_sources/firebase/home_tab_firebase_ds_impl.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/to_firebase/to_firebase_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../order_details/data/sources/order_details_ds_impl_test.mocks.dart';


@GenerateMocks([FirebaseService])
void main() {
  late FirebaseService mockFirebaseService;
  late HomeTabFirebaseDataSourceImpl homeTabFirebaseDataSourceImpl;
  late ToFirebaseDto toFirebaseDto;
  late OrdersDto ordersDto;
  late DriverDataDto driverDataDto;
  late LatLng driverLocation;

  setUpAll(() {
    mockFirebaseService = MockFirebaseService();
    homeTabFirebaseDataSourceImpl = HomeTabFirebaseDataSourceImpl(mockFirebaseService);

    ordersDto = OrdersDto(
      id: 'O1',
      orderNumber: '12345',
      totalPrice: 250,
    );

    driverDataDto = DriverDataDto(
      id: 'D1',
      firstName: 'Ahmed',
      lastName: 'Fayed',
      email: 'ahmed@example.com',
      phone: '0100000',
    );

    driverLocation = const LatLng(30.0444, 31.2357);

    toFirebaseDto = ToFirebaseDto(
      userState: 'active',
      driverData: driverDataDto,
      orders: ordersDto,
      driverLocation: driverLocation,
    );
  });

  group('✅ Test HomeTabFirebaseDataSourceImpl in Data Layer', () {
    test('success case for saveOrder should call addData once', () async {
      // Arrange
      when(
        mockFirebaseService.addData(
          AppConstants.ordersCollection,
          toFirebaseDto.orders!.id!,
          toFirebaseDto.toJson(),
        ),
      ).thenAnswer((_) async => Future.value());

      await homeTabFirebaseDataSourceImpl.saveOrder(toFirebaseDto);

      verify(
        mockFirebaseService.addData(
          AppConstants.ordersCollection,
          toFirebaseDto.orders!.id!,
          toFirebaseDto.toJson(),
        ),
      ).called(1);
    });
  });
}
