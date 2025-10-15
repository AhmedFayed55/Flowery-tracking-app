import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/sources/forget_password_remote_ds_impl.dart';

import 'forget_password_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late ForgetPasswordRemoteDsImpl remoteDs;

  setUp(() {
    mockApiServices = MockApiServices();
    remoteDs = ForgetPasswordRemoteDsImpl(mockApiServices);
  });

  group('ForgetPasswordRemoteDsImpl Tests', () {
    test(
      'forgotPassword should call ApiServices and return response',
      () async {
        final request = ForgotPasswordRequest(email: 'test@test.com');
        final response = ForgetPasswordRespone(message: 'success');

        when(
          mockApiServices.forgotPassword(request),
        ).thenAnswer((_) async => response);

        final result = await remoteDs.forgotPassword(request);

        expect(result, response);
        verify(mockApiServices.forgotPassword(request)).called(1);
      },
    );

    test('resetPassword should call ApiServices and return response', () async {
      final body = ResetPasswordBody(
        newPassword: '123456',
        email: 'test@test.com',
      );
      final response = ResetPasswordRespone(message: 'reset success');

      when(
        mockApiServices.resetPassword(body),
      ).thenAnswer((_) async => response);

      final result = await remoteDs.resetPassword(body);

      expect(result, response);
      verify(mockApiServices.resetPassword(body)).called(1);
    });

    test('verifyCode should call ApiServices and return response', () async {
      final body = VerifyPasswordBody(resetCode: '123456');
      final response = VerifyPasswordRespone(status: 'code verified');

      when(mockApiServices.verifyCode(body)).thenAnswer((_) async => response);

      final result = await remoteDs.verifyCode(body);

      expect(result, response);
      verify(mockApiServices.verifyCode(body)).called(1);
    });
  });
}
