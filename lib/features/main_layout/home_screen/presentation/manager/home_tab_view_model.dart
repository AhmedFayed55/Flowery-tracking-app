import 'dart:developer';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/save_order_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/errors/firebase_results.dart';
import '../../../../../core/helpers/shared_pref.dart';
import '../../../../../core/utils/constants.dart';
import '../../domain/entities/orders_entity.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabState>{

  HomeTabViewModel(this._getAllPendingOrdersUseCase, this._saveOrderUseCase):super(const HomeTabState());

  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;
  final SaveOrderUseCase _saveOrderUseCase;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  Future<void> doIntent(HomeTabEvent event) {
    switch (event) {
      case GetAllPendingOrdersEvent():
        return _getAllPendingOrders();
      case RejectOrderEvent(:final orderId):
        _deleteOrder(orderId);
        return Future.value();
      case SaveOrderEvent(:final order):
        return _saveOrder(order);
    }
  }

  Future<void> _saveOrder(OrdersEntity order)async{
    emit(state.copyWith(isLoadingSaveOrder: true, errorSaveOrder: null));
    var result =  await _saveOrderUseCase.invoke(order);
    switch(result){
      case FirebaseSuccessResult():
        getIt<SharedPrefHelper>().saveData(key: AppConstants.orderId, val: order.id);
        emit(state.copyWith(isLoadingSaveOrder: false,isOrderSaved: true));
      case FirebaseErrorResult():
        emit(state.copyWith(isLoadingSaveOrder: false,errorSaveOrder: result.failure.errorMessage));
    }
  }

  Future<void> _getAllPendingOrders()async{
    emit(state.copyWith(isLoadingGetOrders: true,orders: [], errorGetOrders: null));
    var result = await _getAllPendingOrdersUseCase.invoke();
    switch(result){
      case ApiSuccessResult():
        emit(state.copyWith(isLoadingGetOrders: false, orders: result.data.orders));
      case ApiErrorResult():
        log("Error is ${result.failure.errorMessage}");
        emit(state.copyWith(isLoadingGetOrders: false, errorGetOrders: result.failure.errorMessage));
    }
  }

  void _deleteOrder(String orderId) {
    emit(state.copyWith(isLoadingGetOrders: true));
    state.orders.removeWhere((order) => order.id == orderId);
    emit(state.copyWith(isLoadingGetOrders: false));
  }

}