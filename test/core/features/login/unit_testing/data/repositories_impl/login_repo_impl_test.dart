import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/services/token_service.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/repositories_impl/login_repo_impl.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_repo_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource, TokenService])
void main() {
  late String email;
  late String password;
  late String value;
  late TokenService mockTokenService;
  late LoginResponseModel loginResponseModel;
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLoginRemoteDataSource mockLoginRemoteDataSource;
  late LoginResponseEntity loginResponseEntity;

  setUpAll(() {
    mockLoginRemoteDataSource = MockLoginRemoteDataSource();
    email = "Email";
    password = "Password";
    value = "token";
    loginResponseModel = LoginResponseModel(token: value);
    mockTokenService = MockTokenService();
    loginResponseEntity = LoginResponseEntity(token: value);
    loginRepositoryImpl = LoginRepositoryImpl(
      loginRemoteDataSource: mockLoginRemoteDataSource,
      secureStorage: mockTokenService,
    );
  });

  group("Test LoginRemoteDataSourceImpl in Data_Layer", () {
    /// Success

    test("success case for login with ApiSuccessResult", () async {
      var mockLoginResponseEntity = ApiSuccessResult<LoginResponseEntity>(
        data: loginResponseEntity,
      );
      provideDummy<ApiResult<LoginResponseEntity>>(mockLoginResponseEntity);

      // Arrange
      when(
        mockLoginRemoteDataSource.login(email, password),
      ).thenAnswer((_) async => loginResponseModel);
      when(mockTokenService.saveToken(value)).thenAnswer((_) async => true);

      // Act
      var result = await loginRepositoryImpl.login(email, password);

      // Assert
      expect(result, isA<ApiSuccessResult<LoginResponseEntity>>());
      var successResult = result as ApiSuccessResult<LoginResponseEntity>;
      expect(successResult.data.token, equals(loginResponseEntity.token));

      verify(mockLoginRemoteDataSource.login(email, password)).called(1);
      verify(mockTokenService.saveToken(value)).called(1);
    });

    test("Error case for login with DioException", () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
      );

      // Arrange
      when(
        mockLoginRemoteDataSource.login(email, password),
      ).thenThrow(dioException);

      // Act
      var result = await loginRepositoryImpl.login(email, password);

      // Assert
      expect(result, isA<ApiErrorResult<LoginResponseEntity>>());
      var errorResult = result as ApiErrorResult<LoginResponseEntity>;
      expect(errorResult.failure, isA<ServerFailure>());

      verify(mockLoginRemoteDataSource.login(email, password)).called(1);
      verifyNever(mockTokenService.saveToken('val'));
    });

    test("Error case for login with generic Exception", () async {
      const errorMessage = "Generic error";
      final exception = Exception(errorMessage);

      // Arrange
      when(
        mockLoginRemoteDataSource.login(email, password),
      ).thenThrow(exception);

      // Act
      var result = await loginRepositoryImpl.login(email, password);

      // Assert
      expect(result, isA<ApiErrorResult<LoginResponseEntity>>());
      var errorResult = result as ApiErrorResult<LoginResponseEntity>;
      expect(errorResult.failure, isA<Failure>());
      expect(errorResult.failure.errorMessage, contains(errorMessage));

      verify(mockLoginRemoteDataSource.login(email, password)).called(1);
      verifyNever(mockTokenService.saveToken('val'));
    });
  });
}
