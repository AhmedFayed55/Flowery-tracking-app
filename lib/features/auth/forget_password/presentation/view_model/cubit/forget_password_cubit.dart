import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/forget_password_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/reset_password_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/verify_code_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_event.dart';
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

  Future<void> doIntent(ForgetPasswordpPageEvent event) async {
    switch (event) {
      case ForgetPasswordEvent():
        forgetPassword(event.email);
        break;
      case ResetPasswordEvent():
        resetPassword(event.password);
        break;
      case VerifyCodeEvent():
        verifyCode(event.code);
        break;
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(
      state.copyWith(
        email: email,
        loading: const ForgetPasswordLoading(
          isVerifyCodeSentLoading: true,
          isOtpCorrectLoading: false,
          isPasswordResetLoading: false,
        ),
        errors: const ForgetPasswordErrors(
          errorOtp: '',
          errorEmail: '',
          errorPassword: '',
        ),
      ),
    );
    final result = await _forgetPasswordUsecase.invoke(
      ForgotPasswordRequest(email: email),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isVerifyCodeSent: true,
            loading: const ForgetPasswordLoading(
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
              isPasswordResetLoading: false,
            ),
            errors: const ForgetPasswordErrors(
              errorOtp: '',
              errorEmail: '',
              errorPassword: '',
            ),
            email: email,
          ),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isVerifyCodeSent: false,
            loading: const ForgetPasswordLoading(
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
              isPasswordResetLoading: false,
            ),
            errors: ForgetPasswordErrors(
              errorOtp: '',
              errorEmail: result.failure.errorMessage,
              errorPassword: '',
            ),
          ),
        );
        break;
    }
  }

  Future<void> verifyCode(String code) async {
    emit(
      state.copyWith(
        loading: const ForgetPasswordLoading(
          isVerifyCodeSentLoading: false,
          isOtpCorrectLoading: true,
          isPasswordResetLoading: false,
        ),
        errors: const ForgetPasswordErrors(
          errorOtp: '',
          errorEmail: '',
          errorPassword: '',
        ),
      ),
    );
    final result = await _verifyCodeUsecase.invoke(
      VerifyPasswordBody(resetCode: code),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isOtpCorrect: true,
            loading: const ForgetPasswordLoading(
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
              isPasswordResetLoading: false,
            ),
          ),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isOtpCorrect: false,
            loading: const ForgetPasswordLoading(
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
              isPasswordResetLoading: false,
            ),
            errors: ForgetPasswordErrors(
              errorOtp: result.failure.errorMessage,
              errorEmail: '',
              errorPassword: '',
            ),
          ),
        );
        break;
    }
  }

  Future<void> resetPassword(String password) async {
    emit(
      state.copyWith(
        loading: const ForgetPasswordLoading(
          isPasswordResetLoading: true,
          isVerifyCodeSentLoading: false,
          isOtpCorrectLoading: false,
        ),
        errors: const ForgetPasswordErrors(
          errorOtp: '',
          errorEmail: '',
          errorPassword: '',
        ),
      ),
    );
    final result = await _resetPasswordUsecase.invoke(
      ResetPasswordBody(newPassword: password, email: state.email),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isPasswordReset: true,
            loading: const ForgetPasswordLoading(
              isPasswordResetLoading: false,
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
            ),
          ),
        );
        break;
      case ApiErrorResult():
        emit(
          state.copyWith(
            loading: const ForgetPasswordLoading(
              isPasswordResetLoading: false,
              isVerifyCodeSentLoading: false,
              isOtpCorrectLoading: false,
            ),
            errors: ForgetPasswordErrors(
              errorOtp: '',
              errorEmail: '',
              errorPassword: result.failure.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
