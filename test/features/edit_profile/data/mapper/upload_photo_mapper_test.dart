import 'package:flowery_tracking_app/features/edit_profile/data/mapper/upload_photo_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';

void main() {
  test('verify when call toEntity it should return entity', () {
    final mockDto = UploadPhotoResponseDto(
      message: 'Photo uploaded successfully',
    );

    final result = mockDto.toEntity();

    expect(result, isA<UploadPhotoResponseEntity>());
    expect(result.message, equals(mockDto.message));
  });
}
