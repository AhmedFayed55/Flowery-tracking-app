import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_request.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/forget_password/forget_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/reset_password/reset_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_body.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/data/models/verify_code/verify_password_respone.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ApiServices _apiServices;
  final InternetConnectionChecker _internetConnectionChecker;
  ForgetPasswordRepoImpl(this._apiServices, this._internetConnectionChecker);
  @override
  Future<ApiResult<ForgetPasswordRespone>> forgotPassword(
    ForgotPasswordRequest body,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return ApiErrorResult(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }
    try {
      final result = await _apiServices.forgotPassword(body);
      return ApiSuccessResult(data: result);
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        return ApiErrorResult(
          failure: Failure(
            errorMessage: 'There is no account with this email address',
          ),
        );
      }
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: dioError),
      );
    } catch (error) {
      return ApiErrorResult(failure: Failure(errorMessage: error.toString()));
    }
  }

  @override
  Future<ApiResult<ResetPasswordRespone>> resetPassword(
    ResetPasswordBody body,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return ApiErrorResult(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }
    try {
      final result = await _apiServices.resetPassword(body);
      return ApiSuccessResult(data: result);
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        return ApiErrorResult(
          failure: Failure(
            errorMessage: 'There is no account with this email address',
          ),
        );
      }
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: dioError),
      );
    } catch (error) {
      return ApiErrorResult(failure: Failure(errorMessage: error.toString()));
    }
  }

  @override
  Future<ApiResult<VerifyPasswordRespone>> verifyCode(
    VerifyPasswordBody body,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;
    if (!isConnected) {
      return ApiErrorResult(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }
    try {
      final result = await _apiServices.verifyCode(body);
      return ApiSuccessResult(data: result);
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 400) {
        return ApiErrorResult(
          failure: Failure(
            errorMessage: 'Reset code is invalid or has expired',
          ),
        );
      }
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: dioError),
      );
    } catch (error) {
      return ApiErrorResult(failure: Failure(errorMessage: error.toString()));
    }
  }
}
