import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/forget_password_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/reset_password_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/verify_code_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUsecase _forgetPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  final VerifyCodeUsecase _verifyCodeUsecase;
  ForgetPasswordCubit(
    this._forgetPasswordUsecase,
    this._resetPasswordUsecase,
    this._verifyCodeUsecase,
  ) : super(const ForgetPasswordState());

  Future<void> forgetPassword(String email) async {
    emit(
      state.copyWith(
        email: email,
        isVerifyCodeSentLoading: true,
        errorEmail: '',
      ),
    );
    final result = await _forgetPasswordUsecase.invoke(
      ForgotPasswordRequest(email: email),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(isvrifyCodeSent: true, isVerifyCodeSentLoading: false),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            errorEmail: result.failure.errorMessage,
            isVerifyCodeSentLoading: false,
          ),
        );
        break;
    }
  }

  Future<void> verifyCode(String code) async {
    emit(state.copyWith(isOtpCorrectLoading: true, errorOtp: ''));
    final result = await _verifyCodeUsecase.invoke(
      VerifyPasswordBody(resetCode: code),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(state.copyWith(isOtpCorrect: true, isOtpCorrectLoading: false));
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            errorOtp: result.failure.errorMessage,
            isOtpCorrectLoading: false,
          ),
        );
        break;
    }
  }

  Future<void> resetPassword(String password) async {
    emit(state.copyWith(isPasswordResetLoading: true, errorPassword: ''));
    final result = await _resetPasswordUsecase.invoke(
      ResetPasswordBody(newPassword: password, email: state.email),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(isPasswordReset: true, isPasswordResetLoading: false),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            errorPassword: result.failure.errorMessage,
            isPasswordResetLoading: false,
          ),
        );
        break;
    }
  }
}
