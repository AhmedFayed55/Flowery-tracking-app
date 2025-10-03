import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/get_order_details_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_order_api_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/domin/usecase/update_order_firebase_usecase.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final GetOrderDetailsUsecase _getOrderDetailsUsecase;
  final UpdateOrderFirebaseUsecase _updateOrderFirebaseUsecase;
  final UpdateOrderApiUsecase _updateOrderApiUsecase;

  OrderDetailsCubit(
    this._getOrderDetailsUsecase,
    this._updateOrderFirebaseUsecase,
    this._updateOrderApiUsecase,
  ) : super(OrderDetailsState.initial());

  Future<void> doIntent(OrderDetailsEvent event) async {
    switch (event) {
      case GetOrderDetailsEvent():
        await getOrderDetails(event.orderId);
      case UpdateOrderStatusFirebaseEvent():
        await updateOrderStatusFirebase(event.orderId, event.status);
      case UpdateOrderStatusApiEvent():
        await updateOrderStatusApi(event.orderId, event.status);
      case ChangeToNextStatusEvent():
        await changeToNextStatus(event.orderId);
    }
  }

  Future<void> getOrderDetails(String orderId) async {
    emit(
      state.copyWith(isSceenLoading: true, isLoading: true, errorMessage: null),
    );
    final result = await _getOrderDetailsUsecase.invoke(orderId);

    if (result is FirebaseSuccessResult<OrdersEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          isSceenLoading: false,
          orderDetails: result.data,
          riderOrderStatus: RiderOrderStatus.fromString(result.data.state!),
        ),
      );
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

  Future<void> updateOrderStatusApi(String orderId, OrderStatus status) async {
    emit(state.copyWith(isUpdating: true, errorMessage: null));

    final result = await _updateOrderApiUsecase.invoke(orderId, status);

    if (result is ApiSuccessResult) {
      final mapped = RiderOrderStatus.fromOrderStatus(status);
      emit(state.copyWith(isUpdating: false, riderOrderStatus: mapped));
    } else if (result is ApiErrorResult) {
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

    if (state.riderOrderStatus == RiderOrderStatus.arrivedToUser) {
      final result = await _updateOrderApiUsecase.invoke(
        orderId,
        OrderStatus.completed,
      );

      if (result is ApiSuccessResult) {
        await updateOrderStatusFirebase(orderId, RiderOrderStatus.delivered);
        getIt<SharedPrefHelper>().removeData(key: AppConstants.orderId);
      } else if (result is ApiErrorResult) {
        emit(
          state.copyWith(
            isUpdating: false,
            errorMessage: result.failure.errorMessage,
          ),
        );
      }
      return;
    }

    final nextStatus = state.riderOrderStatus!.nextStatus();
    await updateOrderStatusFirebase(orderId, nextStatus);
  }
}
