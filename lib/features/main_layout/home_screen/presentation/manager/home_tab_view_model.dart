import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/to_firebase/to_firebase_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_logged_driver_data_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/save_order_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/errors/firebase_result.dart';
import '../../../../../core/helpers/shared_pref.dart';
import '../../../../../core/utils/constants.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabState> {
  HomeTabViewModel(
    this._getAllPendingOrdersUseCase,
    this._saveOrderUseCase,
    this._loggedDriverDataUseCase,
  ) : super(const HomeTabState());

  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;
  final SaveOrderUseCase _saveOrderUseCase;
  final GetLoggedDriverDataUseCase _loggedDriverDataUseCase;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  doIntent(HomeTabEvent event) {
    switch (event) {
      case GetAllPendingOrdersEvent(:final page, :final isLoadMore):
        _getAllPendingOrders(page: page, isLoadMore: isLoadMore);
      case RejectOrderEvent(:final orderId):
        _deleteOrder(orderId);
      case SaveOrderEvent(:final order):
        _saveOrder(order);
      case GetLoggedDriverDataEvent():
        _getLoggedDriverData();
    }
  }

  Future<void> _getLoggedDriverData() async {
    emit(state.copyWith(driverData: null));
    var result = await _loggedDriverDataUseCase.invoke();
    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(driverData: result.data));
      case ApiErrorResult<DriverDataEntity>():
        emit(state.copyWith(driverData: null));
    }
  }

  Future<void> _saveOrder(OrdersEntity order) async {
    emit(state.copyWith(isLoadingSaveOrder: true, errorSaveOrder: null));
    var result = await _saveOrderUseCase.invoke(
      ToFirebaseEntity(orders: order, driverData: state.driverData),
    );
    switch (result) {
      case FirebaseSuccessResult():
        getIt<SharedPrefHelper>().saveData(
          key: AppConstants.orderId,
          val: order.id,
        );
        emit(state.copyWith(isLoadingSaveOrder: false, isOrderSaved: true));
      case FirebaseErrorResult():
        emit(
          state.copyWith(
            isLoadingSaveOrder: false,
            errorSaveOrder: result.failure.errorMessage,
          ),
        );
    }
  }

  Future<void> _getAllPendingOrders({
    required int page,
    required bool isLoadMore,
  }) async {
    // Don't load if already loading or no more data
    if (state.isLoadingMore || (!state.hasMoreData && isLoadMore)) {
      return;
    }

    if (isLoadMore) {
      emit(state.copyWith(isLoadingMore: true, errorGetOrders: null));
    } else {
      emit(
        state.copyWith(
          isLoadingGetOrders: true,
          orders: [],
          errorGetOrders: null,
          isOrderSaved: false,
          currentPage: 1,
          hasMoreData: true,
        ),
      );
    }

    var result = await _getAllPendingOrdersUseCase.invoke(page: page);

    switch (result) {
      case ApiSuccessResult():
        final newOrders = result.data.orders ?? [];
        final totalPages = result.data.metadata?.totalPages?.toInt();
        final hasMore = totalPages != null && page < totalPages;

        if (isLoadMore) {
          emit(
            state.copyWith(
              isLoadingMore: false,
              orders: [...state.orders, ...newOrders],
              currentPage: page,
              totalPages: totalPages,
              hasMoreData: hasMore,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoadingGetOrders: false,
              orders: newOrders,
              currentPage: page,
              totalPages: totalPages,
              hasMoreData: hasMore,
            ),
          );
        }
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoadingGetOrders: false,
            isLoadingMore: false,
            errorGetOrders: result.failure.errorMessage,
          ),
        );
    }
  }

  void _deleteOrder(String orderId) {
    final updatedOrders = List<OrdersEntity>.from(state.orders)
      ..removeWhere((order) => order.id == orderId);
    emit(state.copyWith(orders: updatedOrders));
  }
}
