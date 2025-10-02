import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  ApiServices apiServices;

  ProfileRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<ApiResult<ProfileResponseEntity>> getProfile() async {
    try {
      var profileResponseModel = await apiServices.getProfile();
      var profileResponseEntity = profileResponseModel.toEntity();
      return ApiSuccessResult<ProfileResponseEntity>(
        data: profileResponseEntity,
      );
    } on DioException catch (dioError) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: dioError),
      );
    } catch (error) {
      return ApiErrorResult<ProfileResponseEntity>(
        failure: Failure(errorMessage: error.toString()),
      );
    }
  }
}
