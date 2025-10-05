import 'package:flowery_tracking_app/features/auth/login_screen/data/models/login_response_model.dart';

abstract class LoginRemoteDataSourceContract {
  Future<LoginResponseModel> login(String email, String password);
}
