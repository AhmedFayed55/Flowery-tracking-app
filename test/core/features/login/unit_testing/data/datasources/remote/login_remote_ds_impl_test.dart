import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds_impl.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late String email;
  late String value;
  late String password;
  late LoginRemoteDataSourceImpl loginRemoteDataSourceImpl;

  setUpAll(() {
    value = "Value";
    mockApiServices = MockApiServices();
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

      // Arrange
      when(
        mockApiServices.login({"email": email, "password": password}),
      ).thenAnswer((_) async => loginResponseModel);

      // Act
      var result = await loginRemoteDataSourceImpl.login(email, password);

      // Assert
      expect(result, isA<LoginResponseModel>());
      var successResult = result;
      expect(successResult.token, equals(loginResponseModel.token));

      verify(
        mockApiServices.login({"email": email, "password": password}),
      ).called(1);
    });
  });
}
