import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/change_password_repo_imp.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/data_source/change_password_ds.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/response/change_password_response_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'change_password_repo_imp_test.mocks.dart';

@GenerateMocks([ChangePasswordDataSource])
void main() {
  MockChangePasswordDataSource mockChangePasswordDataSource =
      MockChangePasswordDataSource();
  var mockResponse = ChangePasswordResponseDto(
    message: 'message',
    token: 'token',
  );
  ChangePasswordRequestDto mockchangePasswordRequestDto =
      ChangePasswordRequestDto(
        newPassword: 'newPassword',
        password: 'oldPassword',
      );
  var repo = ChangePasswordRepoImp(
    changePasswordDataSource: mockChangePasswordDataSource,
  );
  ChangePasswordRequestEntity changePasswordRequestEntity =
      ChangePasswordRequestEntity(
        newPassword: 'newPassword',
        oldPassword: 'oldPassword',
      );

  group('test repo', () {
    test(
      'verify when call changePasswordrepo is return changePasswordDs in success',
      () async {
        when(
          mockChangePasswordDataSource.changePassword(
            mockchangePasswordRequestDto,
          ),
        ).thenAnswer((_) async => mockResponse);
        var result = await repo.changePassword(changePasswordRequestEntity);
        verify(mockChangePasswordDataSource.changePassword(any)).called(1);
        expect(result, isA<ApiResult<void>>());
      },
    );
    test(
      'verify when call changePasswordrepo is return changePasswordDs in error',
      () async {
        when(
          mockChangePasswordDataSource.changePassword(
            mockchangePasswordRequestDto,
          ),
        ).thenThrow(Exception('erorr'));
        var result = await repo.changePassword(changePasswordRequestEntity);
        verify(mockChangePasswordDataSource.changePassword(any)).called(1);
        expect(result, isA<ApiResult<void>>());
      },
    );
  });
}
