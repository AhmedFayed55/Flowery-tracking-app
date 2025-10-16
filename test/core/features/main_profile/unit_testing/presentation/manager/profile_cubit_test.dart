import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/logout_usecase.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/profile_usecase.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_view_model.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([ProfileUseCase, LogoutUseCase])
void main() {
  late MockProfileUseCase mockProfileUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late ProfileCubit profileCubit;
  late DriverDtoEntity driverDtoEntity;
  late VehicleDtoEntity vehicleDtoEntity;
  late LogoutResponseEntity logoutResponseEntity;

  setUp(() {
    mockProfileUseCase = MockProfileUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    profileCubit = ProfileCubit(
      mockLogoutUseCase,
      profileUseCase: mockProfileUseCase,
    );

    driverDtoEntity = DriverDtoEntity(vehicleType: "car");
    vehicleDtoEntity = VehicleDtoEntity(id: "1", type: "car");
    logoutResponseEntity = LogoutResponseEntity(message: "Logout successful");
  });

  group("ProfileCubit doIntent -> GetProfileEvent", () {
    test("emit success for driver then success for vehicle", () async {
      final driverSuccess = ApiSuccessResult<DriverDtoEntity>(data: driverDtoEntity);
      final vehicleSuccess = ApiSuccessResult<VehicleDtoEntity>(data: vehicleDtoEntity);

      provideDummy<ApiResult<DriverDtoEntity>>(driverSuccess);
      provideDummy<ApiResult<VehicleDtoEntity>>(vehicleSuccess);

      when(mockProfileUseCase.getProfile()).thenAnswer((_) async => driverSuccess);
      when(mockProfileUseCase.getVehicle("car")).thenAnswer((_) async => vehicleSuccess);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, true);
      expect(profileCubit.state.isError, false);
      expect(profileCubit.state.driverDtoEntity, driverDtoEntity);
      expect(profileCubit.state.vehicleDtoEntity, vehicleDtoEntity);
      expect(profileCubit.state.showMessage, isNull);

      verify(mockProfileUseCase.getProfile()).called(1);
      verify(mockProfileUseCase.getVehicle("car")).called(1);
    });

    test("emit error when driverResult is ApiErrorResult", () async {
      final failure = Failure(errorMessage: "Profile error");
      final driverError = ApiErrorResult<DriverDtoEntity>(failure: failure);
      provideDummy<ApiResult<DriverDtoEntity>>(driverError);

      when(mockProfileUseCase.getProfile()).thenAnswer((_) async => driverError);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isError, true);
      expect(profileCubit.state.isSuccess, false);
      expect(profileCubit.state.showMessage, equals("Profile error"));
      expect(profileCubit.state.driverDtoEntity, isNull);
      expect(profileCubit.state.vehicleDtoEntity, isNull);

      verify(mockProfileUseCase.getProfile()).called(1);
      verifyNever(mockProfileUseCase.getVehicle(any));
    });

    test("emit error with message 'vehicle not found' when vehicleType is null", () async {
      final driverWithoutVehicle = DriverDtoEntity(vehicleType: null);
      final driverSuccess = ApiSuccessResult<DriverDtoEntity>(data: driverWithoutVehicle);
      provideDummy<ApiResult<DriverDtoEntity>>(driverSuccess);

      provideDummy<ApiResult<VehicleDtoEntity>>(
        ApiSuccessResult<VehicleDtoEntity>(data: VehicleDtoEntity()),
      );

      when(mockProfileUseCase.getProfile()).thenAnswer((_) async => driverSuccess);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isError, true);
      expect(profileCubit.state.isSuccess, true);
      expect(profileCubit.state.showMessage, equals("vehicle not found"));

      verify(mockProfileUseCase.getProfile()).called(1);
      verifyNever(mockProfileUseCase.getVehicle(any));
    });


    test("emit error state when vehicleResult is ApiErrorResult", () async {
      final driverSuccess = ApiSuccessResult<DriverDtoEntity>(data: driverDtoEntity);
      final vehicleError = ApiErrorResult<VehicleDtoEntity>(
        failure: Failure(errorMessage: "Vehicle error"),
      );

      provideDummy<ApiResult<DriverDtoEntity>>(driverSuccess);
      provideDummy<ApiResult<VehicleDtoEntity>>(vehicleError);

      when(mockProfileUseCase.getProfile()).thenAnswer((_) async => driverSuccess);
      when(mockProfileUseCase.getVehicle("car")).thenAnswer((_) async => vehicleError);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isError, true);
      expect(profileCubit.state.isSuccess, false);

      verify(mockProfileUseCase.getProfile()).called(1);
      verify(mockProfileUseCase.getVehicle("car")).called(1);
    });
  });

  group("ProfileCubit doIntent -> LogoutEvent", () {
    test("emit successLogout when logout succeeds", () async {
      final logoutSuccess = ApiSuccessResult<LogoutResponseEntity>(
        data: logoutResponseEntity,
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(logoutSuccess);

      when(mockLogoutUseCase.invoke()).thenAnswer((_) async => logoutSuccess);

      await profileCubit.doIntent(LogoutEvent());

      expect(profileCubit.state.isSuccessLogout, true);
      expect(profileCubit.state.errorMsgLogout, isNull);

      verify(mockLogoutUseCase.invoke()).called(1);
    });

    test("emit errorMsgLogout when logout fails", () async {
      final logoutError = ApiErrorResult<LogoutResponseEntity>(
        failure: Failure(errorMessage: "Logout failed"),
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(logoutError);

      when(mockLogoutUseCase.invoke()).thenAnswer((_) async => logoutError);

      await profileCubit.doIntent(LogoutEvent());

      expect(profileCubit.state.isSuccessLogout, false);
      expect(profileCubit.state.errorMsgLogout, equals("Logout failed"));

      verify(mockLogoutUseCase.invoke()).called(1);
    });
  });
}
