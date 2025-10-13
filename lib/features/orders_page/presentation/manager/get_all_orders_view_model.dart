import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/usecases/get_all_orders_usecase.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'get_all_orders_state.dart';

@injectable
class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  final GetAllOrdersUseCase getAllOrdersUseCase;

  GetAllOrdersCubit({required this.getAllOrdersUseCase}) : super(GetAllOrdersState());

  Future<void> doIntent(GetAllDriverOrdersEvent event) async {
    switch (event) {
      case GetAllOrdersEvent():
        await _getAllDriverOrders();
        break;
    }
  }

  Future<void> _getAllDriverOrders() async {
    emit(state.copyWith(isLoading: true));
    var getAllOrdersEntity = await getAllOrdersUseCase.getAllDriverOrders();
    switch (getAllOrdersEntity) {
      case ApiSuccessResult<GetAllOrdersEntity>():
        emit(state.copyWith(isLoading: false, isSuccess: true,getAllOrdersEntity: getAllOrdersEntity.data));
        break;
      case ApiErrorResult<GetAllOrdersEntity>():
        emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}