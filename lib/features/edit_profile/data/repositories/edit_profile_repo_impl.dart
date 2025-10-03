import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
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
  ) {
    return _profileRemoteDataSource.editProfile(editProfileRequestEntity);
  }

  @override
  Future<ApiResult<GetLoggedDriverResponseEntity>> getLoggedUserData() {
    return _profileRemoteDataSource.getLoggedUserData();
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
    File imageFile,
  ) {
    return _profileRemoteDataSource.uploadProfilePhoto(imageFile);
  }

  @override
  Future<ApiResult<VehiclesResponseEntity>> getVehicles() {
    return _profileRemoteDataSource.getVehicles();
  }

  @override
  Future<ApiResult<EditProfileResponseEntity>> updateVehicle(
    EditVehicleRequestEntity editVehicleRequestEntity,
  ) {
    return _profileRemoteDataSource.updateVehicle(editVehicleRequestEntity);
  }
}
