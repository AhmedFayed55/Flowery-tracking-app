import 'dart:io';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/vehicle_response_dto.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<EditProfileResponseDto> editProfile(
    EditProfileRequestModel editProfileRequestModel,
  );

  Future<GetLoggedDriverResponseDto> getLoggedUserData();

  Future<UploadPhotoResponseDto> uploadProfilePhoto(File imageFile);

  Future<VehiclesResponseDto> getVehicles();

  Future<EditProfileResponseDto> updateVehicle(
    EditVehicleRequestModel editVehicleRequestModel,
  );
}
