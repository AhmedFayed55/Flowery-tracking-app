import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/all_vehicles_use_case.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/apply_use_case.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_event.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyViewModel extends Cubit<ApplyState> {
  final ApplyUseCase _applyUseCase;
  final AllVehiclesUseCase _allVehiclesUseCase;
  ApplyViewModel(this._applyUseCase, this._allVehiclesUseCase)
    : super(ApplyState());

  void doIntent(ApplyEvent event) {
    switch (event) {
      case ApplyDriverEvent():
        _applyDriver(event.requestEntity);
      case GetVehiclesEvent():
        _getAllVehicles();
    }
  }

  Future<void> _applyDriver(RequestApplyEntity requestEntity) async {
    emit(state.copyWith(isLoading: true));
    final result = await _applyUseCase(requestEntity);
    switch (result) {
      case ApiSuccessResult():
        return emit(state.copyWith(isLoading: false, driver: result.data));
      case ApiErrorResult():
        return emit(
          state.copyWith(
            isLoading: false,
            errorMessage: result.failure.errorMessage,
          ),
        );
    }
  }

  Future<void> _getAllVehicles() async {
    var result = await _allVehiclesUseCase();
    switch (result) {
      case ApiSuccessResult():
        return emit(state.copyWith(vehicelEntity: result.data));
      case ApiErrorResult():
        return emit(state.copyWith(errorMessage: result.failure.errorMessage));
    }
  }
}
