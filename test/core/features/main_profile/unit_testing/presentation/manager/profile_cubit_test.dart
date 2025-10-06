import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/profile_usecase.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_cubit.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([ProfileUseCase])
void main() {
  late MockProfileUseCase mockProfileUseCase;
  late ProfileCubit profileCubit;
  late DriverDtoEntity driverDtoEntity;

  setUp(() {
    mockProfileUseCase = MockProfileUseCase();
    profileCubit = ProfileCubit(profileUseCase: mockProfileUseCase);

    driverDtoEntity = DriverDtoEntity(firstName: "John", lastName: "Doe");
  });

  group("ProfileCubit doIntent -> GetProfileEvent", () {
    test("emit success state for ApiSuccessResult", () async {
      /// Arrange
      var successResult = ApiSuccessResult<DriverDtoEntity>(
        data: driverDtoEntity,
      );
      provideDummy<ApiResult<DriverDtoEntity>>(successResult);

      when(mockProfileUseCase.call()).thenAnswer((_) async => successResult);

      /// Act
      await profileCubit.doIntent(GetProfileEvent());

      /// Assert
      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, true);
      expect(profileCubit.state.isError, false);
      expect(profileCubit.state.driverDtoEntity, driverDtoEntity);

      verify(mockProfileUseCase.call()).called(1);
    });

    test("emit error state for ApiErrorResult", () async {
      /// Arrange
      var failure = Failure(errorMessage: "Error");
      var errorResult = ApiErrorResult<DriverDtoEntity>(failure: failure);
      provideDummy<ApiResult<DriverDtoEntity>>(errorResult);

      when(mockProfileUseCase.call()).thenAnswer((_) async => errorResult);

      /// Act
      await profileCubit.doIntent(GetProfileEvent());

      /// Assert
      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, false);
      expect(profileCubit.state.isError, true);
      expect(profileCubit.state.driverDtoEntity, null);

      verify(mockProfileUseCase.call()).called(1);
    });
  });
}
