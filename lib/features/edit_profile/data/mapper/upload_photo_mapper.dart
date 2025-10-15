import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';

extension UploadPhotoMapper on UploadPhotoResponseDto {
  UploadPhotoResponseEntity toEntity() {
    return UploadPhotoResponseEntity(message: message);
  }
}
