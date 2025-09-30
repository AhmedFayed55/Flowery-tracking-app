import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';

abstract class LoginRemoteDataSourceContract {
  Future<ApiResult<LoginResponseEntity>> login(String email, String password);
}
