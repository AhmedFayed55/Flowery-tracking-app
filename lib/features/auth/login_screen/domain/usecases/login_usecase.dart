import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/repositories/login_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  LoginRepositoryContract loginRepositoryContract;

  LoginUseCase({required this.loginRepositoryContract});

  Future<ApiResult<LoginResponseEntity>> call(
    String email,
    String password,
  ) async {
    var result = await loginRepositoryContract.login(email, password);
    return result;
  }
}
