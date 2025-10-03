import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<ApiResult<EditProfileResponseDto>> editProfile(
    EditProfileRequestModel editProfileRequestModel,
  );

  Future<ApiResult<GetLoggedDriverResponseDto>> getLoggedUserData();

  Future<ApiResult<UploadPhotoResponseDto>> uploadProfilePhoto(File imageFile);

  Future<ApiResult<VehiclesResponseDto>> getVehicles();

  Future<ApiResult<EditProfileResponseDto>> updateVehicle(
    EditVehicleRequestModel editVehicleRequestModel,
  );
}
