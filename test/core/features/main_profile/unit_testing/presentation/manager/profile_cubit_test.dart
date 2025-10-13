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
    test("emit success state when both profile and vehicle succeed", () async {
      var driverSuccess = ApiSuccessResult<DriverDtoEntity>(
        data: driverDtoEntity,
      );
      var vehicleSuccess = ApiSuccessResult<VehicleDtoEntity>(
        data: vehicleDtoEntity,
      );

      provideDummy<ApiResult<DriverDtoEntity>>(driverSuccess);
      provideDummy<ApiResult<VehicleDtoEntity>>(vehicleSuccess);

      when(
        mockProfileUseCase.getProfile(),
      ).thenAnswer((_) async => driverSuccess);
      when(
        mockProfileUseCase.getVehicle(any),
      ).thenAnswer((_) async => vehicleSuccess);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, true);
      expect(profileCubit.state.isError, false);
      expect(profileCubit.state.driverDtoEntity, driverDtoEntity);
      expect(profileCubit.state.vehicleDtoEntity, vehicleDtoEntity);

      verify(mockProfileUseCase.getProfile()).called(1);
      verify(mockProfileUseCase.getVehicle("car")).called(1);
    });

    test("emit error state when driverResult is ApiErrorResult", () async {
      var failure = Failure(errorMessage: "Profile error");
      var driverError = ApiErrorResult<DriverDtoEntity>(failure: failure);
      provideDummy<ApiResult<DriverDtoEntity>>(driverError);

      when(
        mockProfileUseCase.getProfile(),
      ).thenAnswer((_) async => driverError);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, false);
      expect(profileCubit.state.isError, true);
      expect(profileCubit.state.driverDtoEntity, null);
      expect(profileCubit.state.vehicleDtoEntity, null);

      verify(mockProfileUseCase.getProfile()).called(1);
      verifyNever(mockProfileUseCase.getVehicle(any));
    });

    test("emit error state when driver vehicleType is null", () async {
      var driverWithoutVehicle = DriverDtoEntity(
        firstName: "John",
        vehicleType: null,
      );
      var driverSuccess = ApiSuccessResult<DriverDtoEntity>(
        data: driverWithoutVehicle,
      );
      provideDummy<ApiResult<DriverDtoEntity>>(driverSuccess);

      when(
        mockProfileUseCase.getProfile(),
      ).thenAnswer((_) async => driverSuccess);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, false);
      expect(profileCubit.state.isError, true);

      verify(mockProfileUseCase.getProfile()).called(1);
      verifyNever(mockProfileUseCase.getVehicle(any));
    });

    test("emit error state when vehicleResult is ApiErrorResult", () async {
      var driverSuccess = ApiSuccessResult<DriverDtoEntity>(
        data: driverDtoEntity,
      );
      var vehicleError = ApiErrorResult<VehicleDtoEntity>(
        failure: Failure(errorMessage: "Vehicle error"),
      );

      provideDummy<ApiResult<DriverDtoEntity>>(driverSuccess);
      provideDummy<ApiResult<VehicleDtoEntity>>(vehicleError);

      when(
        mockProfileUseCase.getProfile(),
      ).thenAnswer((_) async => driverSuccess);
      when(
        mockProfileUseCase.getVehicle(any),
      ).thenAnswer((_) async => vehicleError);

      await profileCubit.doIntent(GetProfileEvent());

      expect(profileCubit.state.isLoading, false);
      expect(profileCubit.state.isSuccess, false);
      expect(profileCubit.state.isError, true);
      expect(profileCubit.state.vehicleDtoEntity, null);

      verify(mockProfileUseCase.getProfile()).called(1);
      verify(mockProfileUseCase.getVehicle("car")).called(1);
    });
  });

  group("ProfileCubit doIntent -> LogoutEvent", () {
    test("emit successLogout when logout succeeds", () async {
      var logoutSuccess = ApiSuccessResult<LogoutResponseEntity>(
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
      var logoutError = ApiErrorResult<LogoutResponseEntity>(
        failure: Failure(errorMessage: "Logout failed"),
      );
      provideDummy<ApiResult<LogoutResponseEntity>>(logoutError);

      when(mockLogoutUseCase.invoke()).thenAnswer((_) async => logoutError);

      await profileCubit.doIntent(LogoutEvent());

      verify(mockLogoutUseCase.invoke()).called(1);

      expect(profileCubit.state.isSuccessLogout, false);
      expect(profileCubit.state.errorMsgLogout, equals("Logout failed"));
    });
  });
}
