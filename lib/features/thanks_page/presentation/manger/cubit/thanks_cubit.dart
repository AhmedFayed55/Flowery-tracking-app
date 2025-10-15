import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/thanks_page/domain/usecase/delete_order_local.dart';
import 'package:flowery_tracking_app/features/thanks_page/domain/usecase/set_order_as_completed_usecase.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_event.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThanksCubit extends Cubit<ThanksState> {
  final SetOrderAsCompletedUsecase _setOrderAsCompletedUsecase;
  final DeleteOrderLocal _deleteOrderLocal;
  ThanksCubit(this._setOrderAsCompletedUsecase, this._deleteOrderLocal)
    : super(const ThanksState());

  void doIntent(ThanksEvent event) {
    switch (event) {
      case InitialThanksEvent():
        setSuccess(event.orderId);
        break;
    }
  }

  void setSuccess(String orderId) async {
    emit(state.copyWith(isLoading: true));
    var result = await _setOrderAsCompletedUsecase.invoke(orderId);
    switch (result) {
      case ApiSuccessResult():
        _deleteOrderLocal.invoke();
        emit(state.copyWith(isSuccess: true, isLoading: false));
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            errorMessage: result.failure.errorMessage,
            isLoading: false,
          ),
        );
        break;
    }
  }
}
