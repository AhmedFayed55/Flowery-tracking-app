import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/features/main_profile/unit_testing/domain/usecases/profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepositoryContract;
  late LogoutUseCase logoutUseCase;
  late LogoutResponseEntity logoutResponseEntity;

  setUpAll(() {
    mockProfileRepositoryContract = MockProfileRepository();
    logoutResponseEntity = LogoutResponseEntity(message: "Logout successful");
    logoutUseCase = LogoutUseCase(mockProfileRepositoryContract);
  });

  group("LogoutUseCase Tests", () {
    test("success case for logout", () async {
      var mockResult = ApiSuccessResult<LogoutResponseEntity>(
        data: logoutResponseEntity,
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(mockResult);

      when(
        mockProfileRepositoryContract.logout(),
      ).thenAnswer((_) async => mockResult);

      var result = await logoutUseCase.invoke();

      verify(mockProfileRepositoryContract.logout()).called(1);

      expect(result, isA<ApiSuccessResult<LogoutResponseEntity>>());
      var success = result as ApiSuccessResult<LogoutResponseEntity>;
      expect(success.data.message, equals("Logout successful"));
    });

    test("error case for logout", () async {
      var errorResult = ApiErrorResult<LogoutResponseEntity>(
        failure: Failure(errorMessage: "Logout failed"),
      );

      when(
        mockProfileRepositoryContract.logout(),
      ).thenAnswer((_) async => errorResult);

      var result = await logoutUseCase.invoke();

      verify(mockProfileRepositoryContract.logout()).called(1);

      expect(result, isA<ApiErrorResult<LogoutResponseEntity>>());
      var error = result as ApiErrorResult<LogoutResponseEntity>;
      expect(error.failure.errorMessage, contains("Logout failed"));
    });
  });
}
