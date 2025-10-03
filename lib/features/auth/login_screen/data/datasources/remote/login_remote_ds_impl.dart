import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/data/datasources/remote/login_remote_ds_contract.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/services/token_service.dart';

@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceContract {
  ApiServices apiServices;
  LoginRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<ApiResult<LoginResponseEntity>> login(
    String email,
    String password,
  ) async {
    try {
      var loginResponseModel = await apiServices.login({
        "email": email,
        "password": password,
      });
      var loginResponseEntity = loginResponseModel.toEntity();
      await getIt<TokenService>().saveToken(loginResponseEntity.token ?? "");
      return ApiSuccessResult<LoginResponseEntity>(data: loginResponseEntity);
    } on DioException catch (dioError) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: dioError),
      );
    } catch (error) {
      return ApiErrorResult<LoginResponseEntity>(
        failure: Failure(errorMessage: error.toString()),
      );
    }
  }
}
