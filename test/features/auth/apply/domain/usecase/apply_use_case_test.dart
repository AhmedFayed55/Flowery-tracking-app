import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/repo/apply_repo.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/apply_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_use_case_test.mocks.dart';

@GenerateMocks([ApplyRepo])
void main() {
  late ApplyRepo mockApplyRepo;
  late ApplyUseCase applyUseCase;
  late RequestApplyEntity requestApplyEntity;
  late DriverEntity driverEntity;

  setUpAll(() {
    mockApplyRepo = MockApplyRepo();

    requestApplyEntity = RequestApplyEntity(
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Fayed",
      vehicleType: "Car",
      vehicleNumber: "ABC-1234",
      vehicleLicense: File("vehicle_license.png"),
      nID: "29901011234567",
      nIDImg: File("nid_img.png"),
      email: "ahmed@test.com",
      gender: "male",
      phone: "01000000000",
      password: "123456",
      rePassword: "123456",
    );

    driverEntity = DriverEntity(
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Fayed",
      vehicleType: "Car",
      vehicleNumber: "ABC-1234",
      vehicleLicense: "vehicle_license.png",
      nID: "29901011234567",
      nIDImg: "nid_img.png",
      email: "ahmed@test.com",
      gender: "male",
      phone: "01000000000",
      photo: "driver_photo.png",
      id: "1",
    );

    applyUseCase = ApplyUseCase(mockApplyRepo);
  });

  test("success case for ApplyUseCase", () async {
    final mockResult = ApiSuccessResult<DriverEntity>(data: driverEntity);
    provideDummy<ApiResult<DriverEntity>>(mockResult);

    when(
      mockApplyRepo.apply(requestApplyEntity),
    ).thenAnswer((_) async => mockResult);

    final result = await applyUseCase.call(requestApplyEntity);

    verify(mockApplyRepo.apply(requestApplyEntity)).called(1);

    expect(result, isA<ApiSuccessResult<DriverEntity>>());
    final success = result as ApiSuccessResult<DriverEntity>;
    expect(success.data.firstName, driverEntity.firstName);
    expect(success.data.email, driverEntity.email);
    expect(success.data.vehicleNumber, driverEntity.vehicleNumber);
  });

  test("error case for ApplyUseCase", () async {
    final errorResult = ApiErrorResult<DriverEntity>(
      failure: Failure(errorMessage: "Application failed"),
    );

    when(
      mockApplyRepo.apply(requestApplyEntity),
    ).thenAnswer((_) async => errorResult);

    final result = await applyUseCase.call(requestApplyEntity);

    verify(mockApplyRepo.apply(requestApplyEntity)).called(1);

    expect(result, isA<ApiErrorResult<DriverEntity>>());
    final error = result as ApiErrorResult<DriverEntity>;
    expect(error.failure.errorMessage, contains("Application failed"));
  });
}
