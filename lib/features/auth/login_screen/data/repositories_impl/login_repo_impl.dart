import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRemoteDataSource loginRemoteDataSource;
  SharedPrefHelper sharedPrefHelper;

  LoginRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.sharedPrefHelper,
  });

  @override
  Future<ApiResult<LoginResponseEntity>> login(
    String email,
    String password,
  ) async {
    return await safeApiCall<LoginResponseEntity>(() async {
      var loginResponseModel = await loginRemoteDataSource.login(
        email,
        password,
      );
      sharedPrefHelper.saveData(
        key: AppConstants.token,
        val: loginResponseModel.token,
      );
      var loginResponseEntity = loginResponseModel.toEntity();
      return loginResponseEntity;
    });
  }
}
