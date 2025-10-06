import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late AllVehiclesUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = AllVehiclesUseCase(mockRepo);
  });

  test(' should call repo.getVehicles() and return success', () async {
    provideDummy<ApiResult<VehiclesResponseEntity>>(
      ApiSuccessResult(
        data: VehiclesResponseEntity(message: 'ok', vehicles: const []),
      ),
    );

    when(mockRepo.getVehicles()).thenAnswer(
      (_) async => ApiSuccessResult(
        data: VehiclesResponseEntity(message: 'ok', vehicles: const []),
      ),
    );

    final result = await useCase.call();

    verify(mockRepo.getVehicles()).called(1);
    expect(result, isA<ApiSuccessResult<VehiclesResponseEntity>>());

    final success = result as ApiSuccessResult<VehiclesResponseEntity>;
    expect(success.data.message, equals('ok'));
  });
}
