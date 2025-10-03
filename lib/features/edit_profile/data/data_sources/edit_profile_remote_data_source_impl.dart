import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/mapper/edit_profile_mappers.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/mapper/upload_photo_mapper.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/mapper/vehicle_mapper.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiServices _profileApiService;
  EditProfileRemoteDataSourceImpl({required ApiServices profileApiService})
    : _profileApiService = profileApiService;

  @override
  Future<ApiResult<EditProfileResponseEntity>> editProfile(
    EditProfileRequestEntity editProfileRequestEntity,
  ) async {
    try {
      final EditProfileResponseDto response = await _profileApiService
          .editProfile(editProfileRequestEntity.toModel());

      return ApiSuccessResult(data: response.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<GetLoggedDriverResponseEntity>> getLoggedUserData() async {
    try {
      final GetLoggedDriverResponseDto response = await _profileApiService
          .getLoggedUserData();

      return ApiSuccessResult(data: response.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
    File imageFile,
  ) async {
    try {
      final UploadPhotoResponseDto response = await _profileApiService
          .uploadProfilePhoto(imageFile);

      return ApiSuccessResult(data: response.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<VehiclesResponseEntity>> getVehicles() async {
    try {
      final VehiclesResponseDto response = await _profileApiService
          .getAllVehicles();

      return ApiSuccessResult(data: response.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<EditProfileResponseEntity>> updateVehicle(
    EditVehicleRequestEntity editVehicleRequestEntity,
  ) async {
    try {
      final EditProfileResponseDto response = await _profileApiService
          .updateVehicle(editVehicleRequestEntity.toModel());

      return ApiSuccessResult(data: response.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }
}
