import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/usecases/login_usecase.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_view_model.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_event.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase, SharedPrefHelper])
void main() {
  late String email;
  late String password;
  late String message;
  late LoginResponseEntity loginResponseEntity;
  late MockLoginUseCase mockLoginUseCase;
  late MockSharedPrefHelper mockSharedPrefHelper;
  late LoginCubit loginCubit;

  setUp(() {
    email = "email";
    password = "password";
    message = "message";
    loginResponseEntity = LoginResponseEntity(message: message);
    mockLoginUseCase = MockLoginUseCase();
    mockSharedPrefHelper = MockSharedPrefHelper();
    if (!getIt.isRegistered<SharedPrefHelper>()) {
      getIt.registerSingleton<SharedPrefHelper>(mockSharedPrefHelper);
    } else {
      getIt.unregister<SharedPrefHelper>();
      getIt.registerSingleton<SharedPrefHelper>(mockSharedPrefHelper);
    }
    loginCubit = LoginCubit(loginUseCase: mockLoginUseCase);
  });

  group("LoginCubit doIntent -> GoToLoginEvent", () {
    test("emit success state for ApiSuccessResult", () async {
      ///Arrange
      var successResult = ApiSuccessResult<LoginResponseEntity>(
        data: loginResponseEntity,
      );
      provideDummy<ApiResult<LoginResponseEntity>>(successResult);

      when(
        mockLoginUseCase.call(email, password),
      ).thenAnswer((_) async => successResult);

      ///Act
      await loginCubit.doIntent(
        GoToLoginEvent(email: email, password: password),
      );

      ///Assert
      expect(loginCubit.state.isLoading, false);
      expect(loginCubit.state.isSuccess, true);
      expect(loginCubit.state.isError, false);

      verify(mockLoginUseCase.call(email, password)).called(1);
    });

    test("emit error state for ApiErrorResult", () async {
      ///Arrange
      var mocFailure = Failure(errorMessage: "Error");
      var errorResult = ApiErrorResult<LoginResponseEntity>(
        failure: mocFailure,
      );
      provideDummy<ApiResult<LoginResponseEntity>>(errorResult);

      when(
        mockLoginUseCase.call(email, password),
      ).thenAnswer((_) async => errorResult);

      ///Act
      await loginCubit.doIntent(
        GoToLoginEvent(email: email, password: password),
      );

      ///Assert
      expect(loginCubit.state.isLoading, false);
      expect(loginCubit.state.isSuccess, false);
      expect(loginCubit.state.isError, true);

      verify(mockLoginUseCase.call(email, password)).called(1);
    });
  });

  group("LoginCubit doIntent -> IsRememberMeEvent", () {
    test("emit isRemember state", () async {
      ///Arrange
      when(
        mockSharedPrefHelper.saveData(
          key: AppConstants.isRemember,
          val: anyNamed('val'),
        ),
      ).thenAnswer((_) async => true);

      ///Act
      await loginCubit.doIntent(IsRememberMeEvent(isRemember: true));

      ///Assert
      expect(loginCubit.state.isRememberMe, true);
      expect(loginCubit.state.isError, false);
      verify(
        mockSharedPrefHelper.saveData(key: AppConstants.isRemember, val: true),
      ).called(1);
    });
  });

  group("LoginCubit doIntent -> EmailChangedEvent & PasswordChangedEvent", () {
    test(
      "emit state with updated email and enable button if password not empty",
      () async {
        // Arrange
        expect(loginCubit.state.email, "");
        expect(loginCubit.state.isButtonEnabled, false);

        // Act
        await loginCubit.doIntent(EmailChangedEvent(email: email));

        // Assert
        expect(loginCubit.state.email, email);
        expect(loginCubit.state.isError, false);
        expect(loginCubit.state.isButtonEnabled, false);
      },
    );

    test(
      "emit state with updated password and enable button if email not empty",
      () async {
        // Arrange
        await loginCubit.doIntent(EmailChangedEvent(email: email));
        expect(loginCubit.state.password, "");
        expect(loginCubit.state.isButtonEnabled, false);

        // Act
        await loginCubit.doIntent(PasswordChangedEvent(password: password));

        // Assert
        expect(loginCubit.state.password, password);
        expect(loginCubit.state.isError, false);
        expect(loginCubit.state.isButtonEnabled, true);
      },
    );
  });
}
