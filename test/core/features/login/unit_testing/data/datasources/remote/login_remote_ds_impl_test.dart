import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds_impl.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices, SharedPrefHelper])
void main() {
  late MockApiServices mockApiServices;
  late MockSharedPrefHelper mockSharedPrefHelper;
  late String email;
  late String value;
  late String password;
  late String errorMessage;
  late LoginRemoteDataSourceImpl loginRemoteDataSourceImpl;

  setUpAll(() {
    value = "Value";
    mockApiServices = MockApiServices();
    mockSharedPrefHelper = MockSharedPrefHelper();
    getIt.registerSingleton<SharedPrefHelper>(mockSharedPrefHelper);
    errorMessage = "Error message";
    email = "Email";
    password = "Password";
    loginRemoteDataSourceImpl = LoginRemoteDataSourceImpl(
      apiServices: mockApiServices,
    );
  });

  group("Test LoginRemoteDataSourceImpl in Data_Layer", () {
    /// Success

    test("success case for login with ApiSuccessResult", () async {
      final loginResponseModel = LoginResponseModel(token: value);
      final loginResponseEntity = LoginResponseEntity(token: value);

      // Arrange
      when(
        mockApiServices.login({"email": email, "password": password}),
      ).thenAnswer((_) async => loginResponseModel);
      when(
        mockSharedPrefHelper.saveData(key: AppConstants.token, val: value),
      ).thenAnswer((_) async => true);

      // Act
      var result = await loginRemoteDataSourceImpl.login(email, password);

      // Assert
      expect(result, isA<ApiSuccessResult<LoginResponseEntity>>());
      var successResult = result as ApiSuccessResult<LoginResponseEntity>;
      expect(successResult.data.token, equals(loginResponseEntity.token));

      verify(
        mockApiServices.login({"email": email, "password": password}),
      ).called(1);
      verify(
        mockSharedPrefHelper.saveData(key: AppConstants.token, val: value),
      ).called(1);
    });

    /// ErrorDioException
    test("ErrorDioException case for login with ApiErrorResult", () async {
      final mockDioException = DioException(
        requestOptions: RequestOptions(),
        message: errorMessage,
      );
      final ServerFailure mockServerFailureFromDioError =
          ServerFailure.fromDioError(dioException: mockDioException);

      /// Arrange
      when(
        mockApiServices.login({"email": email, "password": password}),
      ).thenThrow(mockDioException);

      /// Act
      var result = await loginRemoteDataSourceImpl.login(email, password);

      /// Assert
      expect(result, isA<ApiErrorResult<LoginResponseEntity>>());
      ApiErrorResult<LoginResponseEntity> errorResult =
          result as ApiErrorResult<LoginResponseEntity>;
      expect(
        errorResult.failure.errorMessage,
        equals(mockServerFailureFromDioError.errorMessage),
      );

      verify(
        mockApiServices.login({"email": email, "password": password}),
      ).called(1);
    });

    /// ErrorException
    test("ErrorException case for login with ApiErrorResult", () async {
      Failure mockFailure = Failure(
        errorMessage: Exception(errorMessage).toString(),
      );

      /// Arrange
      when(
        mockApiServices.login({"email": email, "password": password}),
      ).thenThrow(Exception(errorMessage));

      /// Act
      var result = await loginRemoteDataSourceImpl.login(email, password);

      /// Assert
      expect(result, isA<ApiErrorResult<LoginResponseEntity>>());
      ApiErrorResult<LoginResponseEntity> errorResult =
          result as ApiErrorResult<LoginResponseEntity>;
      expect(
        errorResult.failure.errorMessage,
        equals(mockFailure.errorMessage),
      );

      verify(
        mockApiServices.login({"email": email, "password": password}),
      ).called(1);
    });
  });
}
