import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiServices _profileApiService;
  EditProfileRemoteDataSourceImpl({required ApiServices profileApiService})
    : _profileApiService = profileApiService;

  @override
  Future<ApiResult<EditProfileResponseDto>> editProfile(
    EditProfileRequestModel editProfileRequestModel,
  ) async {
    return safeApiCall(
      () => _profileApiService.editProfile(editProfileRequestModel),
    );
  }

  @override
  Future<ApiResult<GetLoggedDriverResponseDto>> getLoggedUserData() async {
    return safeApiCall(() => _profileApiService.getLoggedUserData());
  }

  @override
  Future<ApiResult<UploadPhotoResponseDto>> uploadProfilePhoto(
    File imageFile,
  ) async {
    return safeApiCall(() => _profileApiService.uploadProfilePhoto(imageFile));
  }

  @override
  Future<ApiResult<VehiclesResponseDto>> getVehicles() async {
    return safeApiCall(() => _profileApiService.getAllVehicles());

  }

  @override
  Future<ApiResult<EditProfileResponseDto>> updateVehicle(
    EditVehicleRequestModel editVehicleRequestModel,
  ) async {
    return safeApiCall(
      () => _profileApiService.updateVehicle(editVehicleRequestModel),
    );
  }
}
