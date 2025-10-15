import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late EditProfileUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = EditProfileUseCase(profileRepo: mockRepo);
  });

  test(' should call repo.editProfile() and return success', () async {
    final driver = DriverEntity(
      id: '1',
      country: 'Egypt',
      firstName: 'Ahmed',
      lastName: 'Rajeh',
      vehicleType: 'Car',
      vehicleNumber: 'BS1234',
      vehicleLicense: '123456',
      NID: '29801011234567',
      NIDImg: 'nid_img_url',
      email: 'ahmed@example.com',
      gender: 'male',
      phone: '+201234567890',
      photo: 'photo_url',
      role: 'driver',
      createdAt: '2025-10-05',
    );

    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiSuccessResult(
        data: EditProfileResponseEntity(message: 'ok', driver: driver),
      ),
    );

    when(mockRepo.editProfile(any)).thenAnswer(
      (_) async => ApiSuccessResult(
        data: EditProfileResponseEntity(message: 'ok', driver: driver),
      ),
    );

    final result = await useCase.invoke(
      EditProfileRequestEntity(
        firstName: 'A',
        lastName: 'B',
        email: 'a@b.com',
        phone: '+201234567890',
      ),
    );

    verify(mockRepo.editProfile(any)).called(1);
    expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());

    final successResult = result as ApiSuccessResult<EditProfileResponseEntity>;
    expect(successResult.data.driver.firstName, equals('Ahmed'));
    expect(successResult.data.message, equals('ok'));
  });
}
