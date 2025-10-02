import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/all_vehicles_use_case.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/apply_use_case.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_event.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyViewModel extends Cubit<ApplyState> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ApplyUseCase _applyUseCase;
  final AllVehiclesUseCase _allVehiclesUseCase;
  ApplyViewModel(this._applyUseCase, this._allVehiclesUseCase)
    : super(ApplyState());
  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    carNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    return super.close();
  }

  void doIntent(ApplyEvent event) {
    switch (event) {
      case ApplyDriverEvent():
        _applyDriver(event.requestEntity);
      case GetVehiclesEvent():
        _getAllVehicles();
    }
  }

  Future<void> _applyDriver(RequestApplyEntity requestEntity) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
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
