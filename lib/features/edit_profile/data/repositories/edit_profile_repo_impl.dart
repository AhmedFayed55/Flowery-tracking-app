import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/mapper/edit_profile_mappers.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/mapper/upload_photo_mapper.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/mapper/vehicle_mapper.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDataSource _profileRemoteDataSource;

  EditProfileRepoImpl({
    required EditProfileRemoteDataSource profileRemoteDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource;

  @override
  Future<ApiResult<EditProfileResponseEntity>> editProfile(
    EditProfileRequestEntity editProfileRequestEntity,
  ) async {
    return await safeApiCall(() async {
      final response = await _profileRemoteDataSource.editProfile(
        editProfileRequestEntity.toModel(),
      );
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<GetLoggedDriverResponseEntity>> getLoggedUserData() async {
    return await safeApiCall(() async {
      final response = await _profileRemoteDataSource.getLoggedUserData();
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
    File imageFile,
  ) async {
    return await safeApiCall(() async {
      final response = await _profileRemoteDataSource.uploadProfilePhoto(
        imageFile,
      );
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<VehiclesResponseEntity>> getVehicles() async {
    return await safeApiCall(() async {
      final response = await _profileRemoteDataSource.getVehicles();
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<EditProfileResponseEntity>> updateVehicle(
    EditVehicleRequestEntity editVehicleRequestEntity,
  ) async {
    return await safeApiCall(() async {
      final response = await _profileRemoteDataSource.updateVehicle(
        editVehicleRequestEntity.toModel(),
      );
      return response.toEntity();
    });
  }
}
