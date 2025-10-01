import 'dart:developer';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabState>{

  HomeTabViewModel(this._getAllPendingOrdersUseCase):super(const HomeTabState());

  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  doIntent(HomeTabEvent event){
    switch(event){
      case GetAllPendingOrdersEvent():
        _getAllPendingOrders();
      case RejectOrderEvent(:final orderId):
        _deleteOrder(orderId);
    }
  }

  Future<void> _getAllPendingOrders()async{
    emit(state.copyWith(isLoadingGetOrders: true,orders: [], errorGetOrders: null));
    var result = await _getAllPendingOrdersUseCase.invoke();
    switch(result){
      case ApiSuccessResult():
        emit(state.copyWith(isLoadingGetOrders: false, orders: result.data.orders));
      case ApiErrorResult():
        emit(state.copyWith(isLoadingGetOrders: false, errorGetOrders: result.failure.errorMessage));
    }
  }

  void _deleteOrder(String orderId) {
    emit(state.copyWith(isLoadingGetOrders: true));
    state.orders.removeWhere((order) => order.id == orderId);
    log("Order with ID $orderId has been removed. Remaining orders: ${state.orders.length}");
    emit(state.copyWith(isLoadingGetOrders: false));
  }

}