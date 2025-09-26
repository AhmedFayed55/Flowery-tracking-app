import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/sources/forget_password_remote_ds_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/repo/forget_password_repo_impl.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker, ForgetPasswordRemoteDsImpl])
void main() {
  late ForgetPasswordRepoImpl forgetPasswordRepoImpl;
  late MockInternetConnectionChecker internetConnectionChecker;
  late MockForgetPasswordRemoteDsImpl forgetPasswordRemoteDsImpl;

  setUpAll(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    forgetPasswordRemoteDsImpl = MockForgetPasswordRemoteDsImpl();
    forgetPasswordRepoImpl = ForgetPasswordRepoImpl(
      forgetPasswordRemoteDsImpl,
      internetConnectionChecker,
    );
  });
  group('forget_password_repo_impl_test', () {
    test('should return ApiErrorResult when no internet connection', () async {
      // arrange
      when(
        internetConnectionChecker.hasConnection,
      ).thenAnswer((_) async => false);

      // act
      final result = await forgetPasswordRepoImpl.forgotPassword(
        ForgotPasswordRequest(email: ''),
      );

      // assert
      expect(result, isA<ApiErrorResult<ForgetPasswordRespone>>());
      final error = result as ApiErrorResult<ForgetPasswordRespone>;
      expect(error.failure.errorMessage, 'No Internet Connection');
      verify(internetConnectionChecker.hasConnection).called(1);
      verifyZeroInteractions(forgetPasswordRemoteDsImpl);
    });
    test(
      'when forgetPassword is called with valid email should return ApiSuccessResult',
      () async {
        // arrange
        when(
          internetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);
        when(
          forgetPasswordRemoteDsImpl.forgotPassword(any),
        ).thenAnswer((_) async => ForgetPasswordRespone());
        // act
        final result = await forgetPasswordRepoImpl.forgotPassword(
          ForgotPasswordRequest(email: ''),
        );
        // assert
        expect(result, isA<ApiSuccessResult<ForgetPasswordRespone>>());
        verify(forgetPasswordRemoteDsImpl.forgotPassword(any)).called(1);
      },
    );

    test(
      'when verifyCode is called with valid code should return ApiSuccessResult',
      () async {
        // arrange
        when(
          internetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);
        when(
          forgetPasswordRemoteDsImpl.verifyCode(any),
        ).thenAnswer((_) async => VerifyPasswordRespone());
        // act
        final result = await forgetPasswordRepoImpl.verifyCode(
          VerifyPasswordBody(resetCode: '874688'),
        );
        // assert
        expect(result, isA<ApiSuccessResult<VerifyPasswordRespone>>());
        verify(forgetPasswordRemoteDsImpl.verifyCode(any)).called(1);
      },
    );

    test(
      'when resetPassword is called with valid body should return ApiSuccessResult',
      () async {
        // arrange
        when(
          internetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);
        when(
          forgetPasswordRemoteDsImpl.resetPassword(any),
        ).thenAnswer((_) async => ResetPasswordRespone());
        // act
        final result = await forgetPasswordRepoImpl.resetPassword(
          ResetPasswordBody(email: 'test@gmail.com', newPassword: '123456'),
        );
        // assert
        expect(result, isA<ApiSuccessResult<ResetPasswordRespone>>());
        verify(forgetPasswordRemoteDsImpl.resetPassword(any)).called(1);
      },
    );

    test(
      'when forgotPassword is called with invalid body should return ApiErrorResult',
      () async {
        // arrange
        when(
          internetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);
        when(
          forgetPasswordRemoteDsImpl.forgotPassword(any),
        ).thenThrow(Exception('error'));
        // act
        final result = await forgetPasswordRepoImpl.forgotPassword(
          ForgotPasswordRequest(email: ''),
        );
        // assert
        expect(result, isA<ApiErrorResult<ForgetPasswordRespone>>());
        expect(
          (result as ApiErrorResult<ForgetPasswordRespone>)
              .failure
              .errorMessage,
          equals('Exception: error'),
        );
        verify(forgetPasswordRemoteDsImpl.forgotPassword(any)).called(1);
      },
    );

    test(
      "when verifyCode is called with invalid body should return ApiErrorResult",
      () async {
        // arrange
        when(
          internetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);
        when(
          forgetPasswordRemoteDsImpl.verifyCode(any),
        ).thenThrow(Exception('error'));
        // act
        final result = await forgetPasswordRepoImpl.verifyCode(
          VerifyPasswordBody(resetCode: '874688'),
        );
        // assert
        expect(result, isA<ApiErrorResult<VerifyPasswordRespone>>());
        expect(
          (result as ApiErrorResult<VerifyPasswordRespone>)
              .failure
              .errorMessage,
          equals('Exception: error'),
        );
        verify(forgetPasswordRemoteDsImpl.verifyCode(any)).called(1);
      },
    );

    test(
      "when call resetPassword with invalid body should return ApiErrorResult",
      () async {
        // arrange
        when(
          internetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);
        when(
          forgetPasswordRemoteDsImpl.resetPassword(any),
        ).thenThrow(Exception('error'));
        // act
        final result = await forgetPasswordRepoImpl.resetPassword(
          ResetPasswordBody(email: "emal.com", newPassword: "newPassword"),
        );
        // assert
        expect(result, isA<ApiErrorResult<ResetPasswordRespone>>());
        expect(
          (result as ApiErrorResult<ResetPasswordRespone>).failure.errorMessage,
          equals('Exception: error'),
        );
        verify(forgetPasswordRemoteDsImpl.resetPassword(any)).called(1);
      },
    );
  });
}
