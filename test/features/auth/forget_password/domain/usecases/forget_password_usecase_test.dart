import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/usecases/forget_password_usecase.dart';

import 'forget_password_usecase_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepo])
void main() {
  late MockForgetPasswordRepo mockRepo;
  late ForgetPasswordUsecase usecase;

  provideDummy<ApiResult<ForgetPasswordRespone>>(
    ApiErrorResult(failure: Failure(errorMessage: "error")),
  );
  setUp(() {
    mockRepo = MockForgetPasswordRepo();
    usecase = ForgetPasswordUsecase(mockRepo);
  });

  group('ForgetPasswordUsecase Tests', () {
    test('should call repo and return success ApiResult', () async {
      // arrange
      final request = ForgotPasswordRequest(email: 'test@test.com');
      final response = ForgetPasswordRespone(message: 'success');
      final apiResult = ApiSuccessResult(data: response);

      when(mockRepo.forgotPassword(request)).thenAnswer((_) async => apiResult);

      // act
      final result = await usecase.invoke(request);

      // assert
      expect(result, apiResult);
      verify(mockRepo.forgotPassword(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should return failure ApiResult when repo fails', () async {
      // arrange
      final request = ForgotPasswordRequest(email: 'fail@test.com');

      when(mockRepo.forgotPassword(request)).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'Some error')),
      );

      // act
      final result = await usecase.invoke(request);

      // assert
      expect(result, isA<ApiErrorResult<ForgetPasswordRespone>>());
      verify(mockRepo.forgotPassword(request)).called(1);
    });
  });
}
