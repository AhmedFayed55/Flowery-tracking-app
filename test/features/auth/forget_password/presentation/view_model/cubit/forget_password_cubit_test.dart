import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/forget_password_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/reset_password_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/verify_code_usecase.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUsecase, ResetPasswordUsecase, VerifyCodeUsecase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUsecase mockForgetPasswordUsecase;
  late MockResetPasswordUsecase mockResetPasswordUsecase;
  late MockVerifyCodeUsecase mockVerifyCodeUsecase;

  provideDummy<ApiResult<ForgetPasswordRespone>>(
    ApiErrorResult(failure: Failure(errorMessage: "error")),
  );

  provideDummy<ApiResult<ResetPasswordRespone>>(
    ApiErrorResult(failure: Failure(errorMessage: "error")),
  );

  provideDummy<ApiResult<VerifyPasswordRespone>>(
    ApiErrorResult(failure: Failure(errorMessage: "error")),
  );

  setUp(() {
    mockForgetPasswordUsecase = MockForgetPasswordUsecase();
    mockResetPasswordUsecase = MockResetPasswordUsecase();
    mockVerifyCodeUsecase = MockVerifyCodeUsecase();

    cubit = ForgetPasswordCubit(
      mockForgetPasswordUsecase,
      mockResetPasswordUsecase,
      mockVerifyCodeUsecase,
    );
  });

  group('ForgetPasswordCubit', () {
    const email = 'test@example.com';
    const password = '123456';
    const code = '9999';
    final dummyResetResponse = ResetPasswordRespone(message: 'ok');
    final dummyForgetResponse = ForgetPasswordRespone(message: 'ok');
    final dummyVerifyResponse = VerifyPasswordRespone(status: 'ok');

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when forgetPassword succeeds',
      build: () {
        when(
          mockForgetPasswordUsecase.invoke(any),
        ).thenAnswer((_) async => ApiSuccessResult(data: dummyForgetResponse));
        return cubit;
      },
      act: (cubit) => cubit.forgetPassword(email),
      expect: () => [
        const ForgetPasswordState().copyWith(
          email: email,
          isVerifyCodeSentLoading: true,
          errorEmail: '',
        ),
        const ForgetPasswordState().copyWith(
          isvrifyCodeSent: true,
          isVerifyCodeSentLoading: false,
          email: email,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when forgetPassword fails',
      build: () {
        when(mockForgetPasswordUsecase.invoke(any)).thenAnswer(
          (_) async =>
              ApiErrorResult(failure: Failure(errorMessage: 'Error Email')),
        );
        return cubit;
      },
      act: (cubit) => cubit.forgetPassword(email),
      expect: () => [
        cubit.state.copyWith(
          email: email,
          isVerifyCodeSentLoading: true,
          errorEmail: '',
        ),
        cubit.state.copyWith(
          errorEmail: 'Error Email',
          isVerifyCodeSentLoading: false,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when verifyCode succeeds',
      build: () {
        when(
          mockVerifyCodeUsecase.invoke(any),
        ).thenAnswer((_) async => ApiSuccessResult(data: dummyVerifyResponse));
        return cubit;
      },
      act: (cubit) => cubit.verifyCode(code),
      expect: () => [
        const ForgetPasswordState().copyWith(
          isOtpCorrectLoading: true,
          errorOtp: '',
        ),
        const ForgetPasswordState().copyWith(
          isOtpCorrect: true,
          isOtpCorrectLoading: false,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when verifyCode fails',
      build: () {
        when(mockVerifyCodeUsecase.invoke(any)).thenAnswer(
          (_) async =>
              ApiErrorResult(failure: Failure(errorMessage: 'Invalid Code')),
        );
        return cubit;
      },
      act: (cubit) => cubit.verifyCode(code),
      expect: () => [
        cubit.state.copyWith(isOtpCorrectLoading: true, errorOtp: ''),
        cubit.state.copyWith(
          isOtpCorrect: false,
          errorOtp: 'Invalid Code',
          isOtpCorrectLoading: false,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when resetPassword succeeds',
      build: () {
        when(
          mockResetPasswordUsecase.invoke(any),
        ).thenAnswer((_) async => ApiSuccessResult(data: dummyResetResponse));
        cubit.emit(cubit.state.copyWith(email: email));
        return cubit;
      },
      act: (cubit) => cubit.resetPassword(password),
      expect: () => [
        const ForgetPasswordState().copyWith(
          email: email,
          isPasswordResetLoading: true,
          errorPassword: '',
        ),
        const ForgetPasswordState().copyWith(
          email: email,
          isPasswordReset: true,
          isPasswordResetLoading: false,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when resetPassword fails',
      build: () {
        when(mockResetPasswordUsecase.invoke(any)).thenAnswer(
          (_) async =>
              ApiErrorResult(failure: Failure(errorMessage: 'Reset Failed')),
        );
        cubit.emit(cubit.state.copyWith(email: email));
        return cubit;
      },
      act: (cubit) => cubit.resetPassword(password),
      expect: () => [
        cubit.state.copyWith(isPasswordResetLoading: true, errorPassword: ''),
        cubit.state.copyWith(
          errorPassword: 'Reset Failed',
          isPasswordResetLoading: false,
        ),
      ],
    );
  });
}
