import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late String message;
  late String token;

  setUpAll(() {
    message = "Message";
    token = "Token";
  });

  test("test loginResponseModel to loginResponseEntity", () {
    LoginResponseModel loginResponseModel = LoginResponseModel(
      message: message,
      token: token,
    );

    LoginResponseEntity loginResponseEntity = LoginResponseEntity(
      message: message,
      token: token,
    );
    var result = loginResponseModel.toEntity();
    expect(loginResponseEntity.message, equals(result.message));
    expect(loginResponseEntity.token, equals(result.token));
  });
}
