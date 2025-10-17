import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_cubit.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/get_order_details_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/stream_in_order_state_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_driver_location_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_order_firebase_usecase.dart';
import 'package:location/location.dart';
import 'order_details_cubit_test.mocks.dart';

@GenerateMocks([
  GetOrderDetailsUsecase,
  StreamOrderUseCase,
  UpdateDriverLocationUsecase,
  UpdateOrderFirebaseUsecase,
  Location,
])
void main() {
  provideDummy<FirebaseResult<OrdersEntity>>(
    FirebaseSuccessResult<OrdersEntity>(
      data: OrdersEntity(id: '1', state: 'pending'),
    ),
  );
  provideDummy<FirebaseResult<dynamic>>(
    FirebaseSuccessResult<dynamic>(data: null),
  );

  late OrderDetailsCubit cubit;
  late MockGetOrderDetailsUsecase mockGetOrderDetailsUsecase;
  late MockStreamOrderUseCase mockStreamOrderUseCase;
  late MockUpdateDriverLocationUsecase mockUpdateDriverLocationUsecase;
  late MockUpdateOrderFirebaseUsecase mockUpdateOrderFirebaseUsecase;
  late MockLocation mockLocation;

  setUp(() {
    mockGetOrderDetailsUsecase = MockGetOrderDetailsUsecase();
    mockStreamOrderUseCase = MockStreamOrderUseCase();
    mockUpdateDriverLocationUsecase = MockUpdateDriverLocationUsecase();
    mockUpdateOrderFirebaseUsecase = MockUpdateOrderFirebaseUsecase();
    mockLocation = MockLocation();

    cubit = OrderDetailsCubit(
      mockStreamOrderUseCase,
      mockLocation,
      mockUpdateDriverLocationUsecase,
      mockGetOrderDetailsUsecase,
      mockUpdateOrderFirebaseUsecase,
    );
  });

  group('OrderDetailsCubit Tests', () {
    test('initial state should be OrderDetailsState.initial()', () {
      expect(cubit.state, OrderDetailsState.initial());
    });

    test('should get order details successfully', () async {
      final order = OrdersEntity(id: '1', state: 'pending');
      when(mockGetOrderDetailsUsecase.invoke('1')).thenAnswer(
        (_) async => FirebaseSuccessResult<OrdersEntity>(data: order),
      );

      await cubit.doIntent(GetOrderDetailsEvent(orderId: '1'));

      expect(cubit.state.orderDetails, order);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.isSceenLoading, false);
      expect(cubit.state.errorMessage, null);
    });

    test('should update order status successfully', () async {
      when(
        mockUpdateOrderFirebaseUsecase.invoke('1', RiderOrderStatus.pending),
      ).thenAnswer((_) async => FirebaseSuccessResult<dynamic>(data: null));

      await cubit.doIntent(
        UpdateOrderStatusFirebaseEvent(
          orderId: '1',
          status: RiderOrderStatus.pending,
        ),
      );

      expect(cubit.state.riderOrderStatus, RiderOrderStatus.pending);
      expect(cubit.state.isUpdating, false);
    });

    test('should handle error when getting order details fails', () async {
      when(mockGetOrderDetailsUsecase.invoke('1')).thenAnswer(
        (_) async => FirebaseErrorResult<OrdersEntity>(
          failure: Failure(errorMessage: 'error'),
        ),
      );

      await cubit.doIntent(GetOrderDetailsEvent(orderId: '1'));

      expect(cubit.state.errorMessage, 'error');
      expect(cubit.state.isLoading, false);
      expect(cubit.state.isSceenLoading, false);
    });
  });
}
