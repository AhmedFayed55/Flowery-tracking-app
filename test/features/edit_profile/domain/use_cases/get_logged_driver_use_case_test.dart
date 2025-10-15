import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/get_logged_driver_use_case.dart';

import 'get_logged_driver_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late GetLoggedDriverUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = GetLoggedDriverUseCase(mockRepo);
  });

  test(
    ' should call repo.getLoggedUserData() and return success with driver object',
    () async {
      final driver = DriverEntity(
        id: "1",
        firstName: 'Ahmed',
        lastName: 'Rajeh',
        gender: 'male',
        NID: '29501011234567',
        NIDImg: 'https://example.com/nid.jpg',
        photo: 'https://example.com/photo.jpg',
        role: 'driver',
        country: 'Egypt',
        vehicleLicense: '123456',
        createdAt: '2024-10-01T10:30:00Z',
        email: 'ahmed@example.com',
        phone: '01000000000',
        vehicleNumber: '1234',
        vehicleType: 'Truck',
      );

      provideDummy<ApiResult<GetLoggedDriverResponseEntity>>(
        ApiSuccessResult(
          data: GetLoggedDriverResponseEntity(message: 'ok', driver: driver),
        ),
      );

      when(mockRepo.getLoggedUserData()).thenAnswer(
        (_) async => ApiSuccessResult(
          data: GetLoggedDriverResponseEntity(message: 'ok', driver: driver),
        ),
      );

      final result = await useCase.call();

      verify(mockRepo.getLoggedUserData()).called(1);
      expect(result, isA<ApiSuccessResult<GetLoggedDriverResponseEntity>>());

      final success = result as ApiSuccessResult<GetLoggedDriverResponseEntity>;
      expect(success.data.message, equals('ok'));
      expect(success.data.driver.firstName, equals('Ahmed'));
      expect(success.data.driver.vehicleType, equals('Truck'));
    },
  );
}
