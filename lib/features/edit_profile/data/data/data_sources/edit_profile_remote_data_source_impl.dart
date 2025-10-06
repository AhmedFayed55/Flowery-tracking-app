import 'dart:io';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiServices _profileApiService;
  EditProfileRemoteDataSourceImpl({required ApiServices profileApiService})
    : _profileApiService = profileApiService;

  @override
  Future<EditProfileResponseDto> editProfile(
    EditProfileRequestModel editProfileRequest,
  ) {
    return _profileApiService.editProfile(editProfileRequest);
  }

  @override
  Future<GetLoggedDriverResponseDto> getLoggedUserData() async {
    return _profileApiService.getLoggedUserData();
  }

  @override
  Future<UploadPhotoResponseDto> uploadProfilePhoto(File imageFile) async {
    return _profileApiService.uploadProfilePhoto(imageFile);
  }

  @override
  Future<VehiclesResponseDto> getVehicles() async {
    return _profileApiService.getAllVehicles();
  }

  @override
  Future<EditProfileResponseDto> updateVehicle(
    EditVehicleRequestModel editVehicleRequestModel,
  ) {
    return _profileApiService.updateVehicle(editVehicleRequestModel);
  }
}
