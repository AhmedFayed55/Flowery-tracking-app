import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/repo/change_password_repo.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/use%20case/change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_use_case_test.mocks.dart';

@GenerateMocks([ChangePasswordRepo])
void main() {
  MockChangePasswordRepo mockChangePasswordRepo = MockChangePasswordRepo();

  ChangePasswordUseCase mockChangePasswordUseCase = ChangePasswordUseCase(
    changePasswordRepo: mockChangePasswordRepo,
  );
  test(
    'verify when call changePasswordUseCase is should return changPasswordRepo in success',
    () async {
      provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));

      when(
        mockChangePasswordRepo.changePassword(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: null));
      var result = await mockChangePasswordUseCase.call(
        ChangePasswordRequestEntity(
          newPassword: 'newPassword',
          oldPassword: 'oldPassword',
        ),
      );
      verify(mockChangePasswordRepo.changePassword(any)).called(1);

      expect(result, isA<ApiResult<void>>());
    },
  );
}
