import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds_contract.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/repositories/login_repo_contract.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: LoginRepositoryContract)
class LoginRepositoryImpl implements LoginRepositoryContract {
  LoginRemoteDataSourceContract loginRemoteDataSourceContract;
  SharedPrefHelper sharedPrefHelper;

  LoginRepositoryImpl({
    required this.loginRemoteDataSourceContract,
    required this.sharedPrefHelper,
  });

  @override
  Future<ApiResult<LoginResponseEntity>> login(
    String email,
    String password,
  ) async {
    return await safeApiCall<LoginResponseEntity>(() async {
      var loginResponseModel = await loginRemoteDataSourceContract.login(
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
