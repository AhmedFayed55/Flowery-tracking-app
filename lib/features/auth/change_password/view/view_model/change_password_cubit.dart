import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/use%20case/change_password_use_case.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_event.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(ChangePasswordState());

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  void doIntent(ChangePasswordEvent event) {
    switch (event) {
      case ChangePassword():
        _changePassword(event.changePasswordRequestEntity);
        break;
    }
  }

  void _changePassword(
    ChangePasswordRequestEntity changePasswordRequestEntity,
  ) async {
    emit(state.copyWith(isLoading: true));
    var result = await _changePasswordUseCase.call(changePasswordRequestEntity);
    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(isLoading: false, isSuccess: true));
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            message: result.failure.errorMessage,
          ),
        );
        break;
    }
  }
}
