import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds_contract.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/repositories_impl/login_repo_impl.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_repo_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSourceContract])
void main() {
  late String email;
  late String password;
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLoginRemoteDataSourceContract mockLoginRemoteDataSourceContract;
  late LoginResponseEntity loginResponseEntity;

  setUpAll(() {
    mockLoginRemoteDataSourceContract = MockLoginRemoteDataSourceContract();
    email = "Email";
    password = "Password";
    loginResponseEntity = LoginResponseEntity(message: "Success");
    loginRepositoryImpl = LoginRepositoryImpl(
      loginRemoteDataSourceContract: mockLoginRemoteDataSourceContract,
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
        mockLoginRemoteDataSourceContract.login(email, password),
      ).thenAnswer((_) async => mockLoginResponseEntity);

      // Act
      var result = await loginRepositoryImpl.login(email, password);

      // Assert
      expect(result, isA<ApiSuccessResult<LoginResponseEntity>>());
      var successResult = result as ApiSuccessResult<LoginResponseEntity>;
      expect(successResult.data.token, equals(loginResponseEntity.token));

      verify(
        mockLoginRemoteDataSourceContract.login(email, password),
      ).called(1);
    });
  });
}
