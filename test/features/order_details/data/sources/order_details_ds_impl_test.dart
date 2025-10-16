import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/core/services/firebase_services.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/core/utils/firebase_constant.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/sources/order_details_ds_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_details_ds_impl_test.mocks.dart';

@GenerateMocks([FirebaseService, DocumentSnapshot])
void main() {
  late OrderDetailsDsImpl dataSource;
  late MockFirebaseService mockFirebaseService;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;

  setUp(() {
    mockFirebaseService = MockFirebaseService();
    mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
    dataSource = OrderDetailsDsImpl(mockFirebaseService);
  });
  group('getOrderDetails', () {
    const orderId = 'order_123';
    final firestoreData = {
      FirebaseConstant.orders: {'_id': orderId, 'state': 'pending'},
    };

    test('returns OrdersDto when document exists', () async {
      when(
        mockFirebaseService.getData(FirebaseConstant.orders, orderId),
      ).thenAnswer((_) async => mockDocumentSnapshot);

      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(firestoreData);

      final result = await dataSource.getOrderDetails(orderId);

      expect(result, isA<OrdersDto>());
      expect(result?.id, equals(orderId));
      expect(result?.state, equals('pending'));
    });

    test('returns null when document does not exist', () async {
      when(
        mockFirebaseService.getData(FirebaseConstant.orders, orderId),
      ).thenAnswer((_) async => mockDocumentSnapshot);

      when(mockDocumentSnapshot.exists).thenReturn(false);

      final result = await dataSource.getOrderDetails(orderId);

      expect(result, isNull);
    });
  });

  group('updateOrderStatusFirebase', () {
    const orderId = 'order_123';
    const status = RiderOrderStatus.delivered;

    test('calls updateData with correct params', () async {
      when(
        mockFirebaseService.updateData(FirebaseConstant.orders, orderId, any),
      ).thenAnswer((_) async => {});

      await dataSource.updateOrderStatusFirebase(orderId, status);

      verify(
        mockFirebaseService.updateData(FirebaseConstant.orders, orderId, {
          FirebaseConstant.orderState: status.statusValue,
        }),
      ).called(1);
    });
  });

  group('updateDriverLocation', () {
    const orderId = 'order_123';
    const location = 'Cairo';

    test('calls updateData with correct params', () async {
      when(
        mockFirebaseService.updateData(FirebaseConstant.orders, orderId, any),
      ).thenAnswer((_) async => {});

      await dataSource.updateDriverLocation(orderId, location);

      verify(
        mockFirebaseService.updateData(FirebaseConstant.orders, orderId, {
          FirebaseConstant.driverLocation: location,
        }),
      ).called(1);
    });
  });

  group('streamOrder', () {
    const orderId = 'order_123';
    final fakeSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

    test('returns stream of DocumentSnapshot<Map>', () {
      when(
        mockFirebaseService.streamData(FirebaseConstant.orders, orderId),
      ).thenAnswer((_) => Stream.value(fakeSnapshot));

      final result = dataSource.streamOrder(orderId);

      expect(result, emits(isA<DocumentSnapshot<Map<String, dynamic>>>()));
    });
  });
}
