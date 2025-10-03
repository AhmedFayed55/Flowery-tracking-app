import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<ApiResult<EditProfileResponseEntity>> editProfile(
    EditProfileRequestEntity editProfileRequestEntity,
  );

  Future<ApiResult<GetLoggedDriverResponseEntity>> getLoggedUserData();
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
    File imageFile,
  );

  Future<ApiResult<VehiclesResponseEntity>> getVehicles();
  Future<ApiResult<EditProfileResponseEntity>> updateVehicle(
    EditVehicleRequestEntity editVehicleRequestEntity,
  );
}
