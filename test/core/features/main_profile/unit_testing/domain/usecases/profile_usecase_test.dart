import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository_contract.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepositoryContract])
void main() {
  late MockProfileRepositoryContract mockProfileRepositoryContract;
  late ProfileUseCase profileUseCase;
  late DriverDtoEntity driverDtoEntity;

  setUpAll(() {
    mockProfileRepositoryContract = MockProfileRepositoryContract();
    driverDtoEntity = DriverDtoEntity(firstName: "John", lastName: "Doe");
    profileUseCase = ProfileUseCase(
      profileRepositoryContract: mockProfileRepositoryContract,
    );
  });

  test("success case for ProfileUseCase", () async {
    var mockResult = ApiSuccessResult<DriverDtoEntity>(data: driverDtoEntity);
    provideDummy<ApiResult<DriverDtoEntity>>(mockResult);

    // Arrange
    when(
      mockProfileRepositoryContract.getProfile(),
    ).thenAnswer((_) async => mockResult);

    // Act
    var result = await profileUseCase.getProfile();

    // Assert
    expect(result, isA<ApiSuccessResult<DriverDtoEntity>>());
    var successResult = result as ApiSuccessResult<DriverDtoEntity>;
    expect(successResult.data.firstName, equals(driverDtoEntity.firstName));
    expect(successResult.data.lastName, equals(driverDtoEntity.lastName));

    verify(mockProfileRepositoryContract.getProfile()).called(1);
  });

  test("error case for ProfileUseCase", () async {
    final errorResult = ApiErrorResult<DriverDtoEntity>(
      failure: Failure(errorMessage: "Generic error"),
    );

    // Arrange
    when(
      mockProfileRepositoryContract.getProfile(),
    ).thenAnswer((_) async => errorResult);

    // Act
    var result = await profileUseCase.getProfile();

    // Assert
    expect(result, isA<ApiErrorResult<DriverDtoEntity>>());
    var error = result as ApiErrorResult<DriverDtoEntity>;
    expect(error.failure, isA<Failure>());
    expect(error.failure.errorMessage, contains("Generic error"));

    verify(mockProfileRepositoryContract.getProfile()).called(1);
  });
}
