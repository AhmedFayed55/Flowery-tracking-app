import 'dart:async';
import 'dart:developer';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/core/utils/firebase_constant.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/get_order_details_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/stream_in_order_state_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_driver_location_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_order_firebase_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final GetOrderDetailsUsecase _getOrderDetailsUsecase;
  final UpdateOrderFirebaseUsecase _updateOrderFirebaseUsecase;
  final UpdateDriverLocationUsecase _updateDriverLocationUsecase;
  final Location _location;
  StreamSubscription<LocationData>? _locationSubscription;
  StreamSubscription<Map<String, dynamic>?>? _orderSubscription;

  final StreamOrderUseCase _streamOrderUseCase;

  OrderDetailsCubit(
    this._streamOrderUseCase,
    this._location,
    this._updateDriverLocationUsecase,
    this._getOrderDetailsUsecase,
    this._updateOrderFirebaseUsecase,
  ) : super(OrderDetailsState.initial());

  Future<void> doIntent(OrderDetailsEvent event) async {
    switch (event) {
      case GetOrderDetailsEvent():
        await getOrderDetails(event.orderId);
      case UpdateOrderStatusFirebaseEvent():
        await updateOrderStatusFirebase(event.orderId, event.status);
      case ChangeToNextStatusEvent():
        await changeToNextStatus(event.orderId);
    }
  }

  void listenToOrder(String orderId) {
    _orderSubscription?.cancel();

    _orderSubscription = _streamOrderUseCase(orderId).listen(
      (data) {
        if (data != null) {
          if (data[FirebaseConstant.userState] ==
              OrderStatus.completed.statusText) {
            emit(state.copyWith(isOrderCompleted: true));
            _orderSubscription?.cancel();
          }
        }
      },
      onError: (error) {
        emit(state.copyWith(errorMessage: error.toString()));
      },
    );
  }

  void closeOrderSubscription() {
    _orderSubscription?.cancel();
  }

  Future<void> getOrderDetails(String orderId) async {
    emit(
      state.copyWith(isSceenLoading: true, isLoading: true, errorMessage: null),
    );
    final result = await _getOrderDetailsUsecase.invoke(orderId);

    if (result is FirebaseSuccessResult<OrdersEntity>) {
      var orderState = RiderOrderStatus.fromString(result.data.state!);
      emit(
        state.copyWith(
          isLoading: false,
          isSceenLoading: false,
          orderDetails: result.data,
          riderOrderStatus: RiderOrderStatus.fromString(result.data.state!),
        ),
      );
      if (orderState != RiderOrderStatus.pending) {
        streamOnDriverLocation();
      }
      if (orderState == RiderOrderStatus.arrivedToUser) {
        listenToOrder(orderId);
      }
    } else if (result is FirebaseErrorResult<OrdersEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          isSceenLoading: false,
          errorMessage: result.failure.errorMessage,
        ),
      );
    }
  }

  Future<void> updateOrderStatusFirebase(
    String orderId,
    RiderOrderStatus status,
  ) async {
    emit(state.copyWith(isUpdating: true, errorMessage: null));
    final result = await _updateOrderFirebaseUsecase.invoke(orderId, status);

    if (result is FirebaseSuccessResult) {
      emit(state.copyWith(isUpdating: false, riderOrderStatus: status));
    } else if (result is FirebaseErrorResult) {
      emit(
        state.copyWith(
          isUpdating: false,
          errorMessage: result.failure.errorMessage,
        ),
      );
    }
  }

  Future<void> changeToNextStatus(String orderId) async {
    emit(state.copyWith(isUpdating: true, errorMessage: null));
    if (state.riderOrderStatus == null) return;

    if (state.riderOrderStatus == RiderOrderStatus.pending) {
      streamOnDriverLocation();
    }

    if (state.riderOrderStatus == RiderOrderStatus.arrivedToUser) {
      log("streaming order");
      listenToOrder(orderId);
    }

    final nextStatus = state.riderOrderStatus!.nextStatus();
    await updateOrderStatusFirebase(orderId, nextStatus);
  }

  void streamOnDriverLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _location.changeSettings(
      accuracy: LocationAccuracy.low,
      interval: 1000,
      distanceFilter: 0,
    );

    _locationSubscription = _location.onLocationChanged.listen((event) {
      log(event.toString());
      _updateDriverLocationUsecase.invoke(
        state.orderDetails!.id!,
        "${event.latitude},${event.longitude}",
      );
    });
  }

  void stopDriverLocationStream() {
    _locationSubscription?.cancel();

    _locationSubscription = null;
  }

  @override
  Future<void> close() {
    stopDriverLocationStream();
    closeOrderSubscription();
    return super.close();
  }
}
