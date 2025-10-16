import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/data/sources/order_details_ds.dart';
import 'package:flowery_tracking_app/features/order_details/data/repo/order_details_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'order_details_repo_impl_test.mocks.dart';

@GenerateMocks([OrderDetailsDs, InternetConnectionChecker])
void main() {
  late OrderDetailsRepoImpl repo;
  late MockOrderDetailsDs mockDs;
  late MockInternetConnectionChecker mockChecker;

  setUp(() {
    mockDs = MockOrderDetailsDs();
    mockChecker = MockInternetConnectionChecker();
    repo = OrderDetailsRepoImpl(mockDs, mockChecker);
  });

  group('getOrderDetails', () {
    const orderId = 'order_123';
    final fakeEntity = OrdersDto(
      id: orderId,
      state: OrderStatus.pending.statusText,
    );

    test('returns success when connected and order exists', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => true);
      when(mockDs.getOrderDetails(orderId)).thenAnswer((_) async => fakeEntity);

      final result = await repo.getOrderDetails(orderId);

      expect(result, isA<FirebaseSuccessResult<OrdersEntity>>());
    });

    test('returns error when no internet', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => false);

      final result = await repo.getOrderDetails(orderId);

      expect(result, isA<FirebaseErrorResult<OrdersEntity>>());
      expect(
        (result as FirebaseErrorResult).failure.errorMessage,
        AppConstants.noInternet,
      );
    });

    test('returns error when Firebase throws exception', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => true);
      when(mockDs.getOrderDetails(orderId)).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Firebase error'),
      );

      final result = await repo.getOrderDetails(orderId);

      expect(result, isA<FirebaseErrorResult<OrdersEntity>>());
    });
  });

  group('updateOrderStatusFirebase', () {
    const orderId = 'order_123';
    var status = RiderOrderStatus.delivered;

    test('returns success when update succeeds', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => true);
      when(
        mockDs.updateOrderStatusFirebase(orderId, status),
      ).thenAnswer((_) async => Future.value());

      final result = await repo.updateOrderStatusFirebase(orderId, status);

      expect(result, isA<FirebaseSuccessResult>());
    });

    test('returns error when no internet', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => false);

      final result = await repo.updateOrderStatusFirebase(orderId, status);

      expect(result, isA<FirebaseErrorResult>());
      expect(
        (result as FirebaseErrorResult).failure.errorMessage,
        AppConstants.noInternet,
      );
    });
  });

  group('updateDriverLocation', () {
    const orderId = 'order_123';
    const location = 'Cairo';

    test('returns success when update succeeds', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => true);
      when(
        mockDs.updateDriverLocation(orderId, location),
      ).thenAnswer((_) async => Future.value());

      final result = await repo.updateDriverLocation(orderId, location);

      expect(result, isA<FirebaseSuccessResult>());
    });

    test('returns error when no internet', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => false);

      final result = await repo.updateDriverLocation(orderId, location);

      expect(result, isA<FirebaseErrorResult>());
      expect(
        (result as FirebaseErrorResult).failure.errorMessage,
        AppConstants.noInternet,
      );
    });
  });

  group('streamOrder', () {
    const orderId = 'order_123';
    final fakeSnapshot = FakeDocumentSnapshot({
      'id': orderId,
      'status': 'pending',
    });

    test('emits correct map data from stream', () {
      when(
        mockDs.streamOrder(orderId),
      ).thenAnswer((_) => Stream.value(fakeSnapshot));

      final stream = repo.streamOrder(orderId);

      expectLater(stream, emits({'id': orderId, 'status': 'pending'}));
    });
  });
}

// ignore: subtype_of_sealed_class
class FakeDocumentSnapshot extends Fake
    implements DocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic>? _data;

  FakeDocumentSnapshot(this._data);

  @override
  Map<String, dynamic>? data() => _data;
}
