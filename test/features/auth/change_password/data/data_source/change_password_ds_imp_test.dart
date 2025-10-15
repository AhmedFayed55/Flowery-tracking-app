import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/data_source/change_password_ds_imp.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/response/change_password_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_ds_imp_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  MockApiServices mockApiServices = MockApiServices();
  ChangePasswordRequestDto mockChangePasswordRequest = ChangePasswordRequestDto(
    password: 'password',
    newPassword: 'newPassword',
  );
  var dataSource = ChangePasswordDataSourceImp(mockApiServices);

  test(
    "verify when call changePasswordDs is return apiService.changePassword ",
    () async {
      when(
        mockApiServices.changePassword(mockChangePasswordRequest),
      ).thenAnswer(
        (_) async =>
            ChangePasswordResponseDto(message: 'message', token: 'token'),
      );
      final result = await dataSource.changePassword(mockChangePasswordRequest);
      verify(
        mockApiServices.changePassword(mockChangePasswordRequest),
      ).called(1);
      expect(result, isA<void>());
    },
  );
}
