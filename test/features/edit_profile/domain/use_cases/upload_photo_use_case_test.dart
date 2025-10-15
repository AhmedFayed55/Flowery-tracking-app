import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late UploadPhotoUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = UploadPhotoUseCase(profileRepo: mockRepo);
  });

  test(' should call repo.uploadProfilePhoto() and return success', () async {
    final file = File('test_assets/profile.jpg');

    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiSuccessResult(data: UploadPhotoResponseEntity(message: 'ok')),
    );

    when(mockRepo.uploadProfilePhoto(file)).thenAnswer(
      (_) async =>
          ApiSuccessResult(data: UploadPhotoResponseEntity(message: 'ok')),
    );

    final result = await useCase.invoke(file);

    verify(mockRepo.uploadProfilePhoto(file)).called(1);
    expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());

    final success = result as ApiSuccessResult<UploadPhotoResponseEntity>;
    expect(success.data.message, equals('ok'));
  });
}
