import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<ApiResult<LoginResponseEntity>> call(
    String email,
    String password,
  ) async {
    var result = await loginRepository.login(email, password);
    return result;
  }
}
