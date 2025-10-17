import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/update_vehicles_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';


@GenerateMocks([EditProfileRepo])
void main() {
  late EditProfileRepo mockEditProfileRepo;
  late UpdateVehiclesUseCase updateVehiclesUseCase;
  late EditVehicleRequestEntity editVehicleRequestEntity;
  late EditProfileResponseEntity editProfileResponseEntity;
  late DriverEntity driverEntity;

  setUpAll(() {
    mockEditProfileRepo = MockEditProfileRepo();

    editVehicleRequestEntity = EditVehicleRequestEntity(
      vehicleType: "Truck",
      vehicleNumber: "551z",
      vehicleLicense: "LICENSE-987",
    );

    driverEntity = DriverEntity(
      id: "1",
      firstName: "Ahmed",
      lastName: "Fayed",
      email: "ahmed@test.com",
      phone: "01000000000",
      password: "123456",
      country: "Egypt",
      gender: "male",
      NID: "29901011234567",
      NIDImg: "nid_img.png",
      photo: "driver_photo.png",
      role: "driver",
      vehicleLicense: "LICENSE-987",
      vehicleNumber: "ABC-123",
      vehicleType: "Truck",
      createdAt: "2025-10-14T12:00:00Z",
    );

    editProfileResponseEntity = EditProfileResponseEntity(
      message: "Vehicle updated successfully",
      driver: driverEntity,
    );

    updateVehiclesUseCase =
        UpdateVehiclesUseCase(profileRepo: mockEditProfileRepo);
  });

  group("UpdateVehiclesUseCase Tests", () {
    test("success case for UpdateVehiclesUseCase", () async {
      final mockResult = ApiSuccessResult<EditProfileResponseEntity>(
        data: editProfileResponseEntity,
      );
      provideDummy<ApiResult<EditProfileResponseEntity>>(mockResult);

      when(
        mockEditProfileRepo.updateVehicle(editVehicleRequestEntity),
      ).thenAnswer((_) async => mockResult);

      final result = await updateVehiclesUseCase.invoke(editVehicleRequestEntity);

      verify(mockEditProfileRepo.updateVehicle(editVehicleRequestEntity)).called(1);

      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      final success = result as ApiSuccessResult<EditProfileResponseEntity>;
      expect(success.data.message, "Vehicle updated successfully");
      expect(success.data.driver.firstName, driverEntity.firstName);
      expect(success.data.driver.lastName, driverEntity.lastName);

    });

    test("error case for UpdateVehiclesUseCase", () async {
      final errorResult = ApiErrorResult<EditProfileResponseEntity>(
        failure: Failure(errorMessage: "Update failed"),
      );

      when(
        mockEditProfileRepo.updateVehicle(editVehicleRequestEntity),
      ).thenAnswer((_) async => errorResult);

      final result = await updateVehiclesUseCase.invoke(editVehicleRequestEntity);

      verify(mockEditProfileRepo.updateVehicle(editVehicleRequestEntity))
          .called(1);

      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      final error = result as ApiErrorResult<EditProfileResponseEntity>;
      expect(error.failure.errorMessage, contains("Update failed"));
    });
  });
}
