import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/repositories/login_repo_contract.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepositoryContract])
void main() {
  late String email;
  late String password;
  late LoginUseCase loginUseCase;
  late MockLoginRepositoryContract mockLoginRepositoryContract;
  late LoginResponseEntity loginResponseEntity;

  setUpAll(() {
    mockLoginRepositoryContract = MockLoginRepositoryContract();
    email = "Email";
    password = "Password";
    loginResponseEntity = LoginResponseEntity(message: "Success");
    loginUseCase = LoginUseCase(
      loginRepositoryContract: mockLoginRepositoryContract,
    );
  });

  /// Success
  test("Test loginUseCase in Domain_Layer", () async {
    var mockLoginResponseEntity = ApiSuccessResult<LoginResponseEntity>(
      data: loginResponseEntity,
    );
    provideDummy<ApiResult<LoginResponseEntity>>(mockLoginResponseEntity);

    // Arrange
    when(
      mockLoginRepositoryContract.login(email, password),
    ).thenAnswer((_) async => mockLoginResponseEntity);

    // Act
    var result = await loginUseCase.call(email, password);

    // Assert
    expect(result, isA<ApiSuccessResult<LoginResponseEntity>>());
    var successResult = result as ApiSuccessResult<LoginResponseEntity>;
    expect(successResult.data.token, equals(loginResponseEntity.token));

    verify(mockLoginRepositoryContract.login(email, password)).called(1);
  });
}
