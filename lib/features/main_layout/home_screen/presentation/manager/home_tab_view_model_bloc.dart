import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/use_cases/get_all_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabState>{

  HomeTabViewModel(this._getAllPendingOrdersUseCase):super(const HomeTabState());

  final GetAllPendingOrdersUseCase _getAllPendingOrdersUseCase;

  doIntent(HomeTabEvent event){
    switch(event){
      case GetAllPendingOrdersEvent():

    }
  }

  Future<void> getAllPendingOrders()async{
    emit(state.copyWith(isLoadingGetOrders: true,getPendingOrdersEntity: null, errorGetOrders: null));
    var result = await _getAllPendingOrdersUseCase.invoke();
    switch(result){
      case ApiSuccessResult():
        emit(state.copyWith(isLoadingGetOrders: false, getPendingOrdersEntity: result.data));
      case ApiErrorResult():
        emit(state.copyWith(isLoadingGetOrders: false, errorGetOrders: result.failure.errorMessage));
    }
  }

}