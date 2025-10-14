import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/repositories/login_repo.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late String email;
  late String password;
  late LoginUseCase loginUseCase;
  late MockLoginRepository mockLoginRepository;
  late LoginResponseEntity loginResponseEntity;

  setUpAll(() {
    mockLoginRepository = MockLoginRepository();
    email = "Email";
    password = "Password";
    loginResponseEntity = LoginResponseEntity(message: "Success");
    loginUseCase = LoginUseCase(loginRepository: mockLoginRepository);
  });

  /// Success
  test("Test loginUseCase in Domain_Layer", () async {
    var mockLoginResponseEntity = ApiSuccessResult<LoginResponseEntity>(
      data: loginResponseEntity,
    );
    provideDummy<ApiResult<LoginResponseEntity>>(mockLoginResponseEntity);

    // Arrange
    when(
      mockLoginRepository.login(email, password),
    ).thenAnswer((_) async => mockLoginResponseEntity);

    // Act
    var result = await loginUseCase.call(email, password);

    // Assert
    expect(result, isA<ApiSuccessResult<LoginResponseEntity>>());
    var successResult = result as ApiSuccessResult<LoginResponseEntity>;
    expect(successResult.data.token, equals(loginResponseEntity.token));

    verify(mockLoginRepository.login(email, password)).called(1);
  });
}
