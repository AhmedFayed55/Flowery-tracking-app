import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final EditProfileRepo _profileRepo;
  UploadPhotoUseCase({required EditProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<ApiResult<UploadPhotoResponseEntity>> invoke(File imageFile) {
    return _profileRepo.uploadProfilePhoto(imageFile);
  }
}
