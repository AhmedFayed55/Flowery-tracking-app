import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/vehicle_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/repositories/edit_profile_repo_impl.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repo_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  late MockEditProfileRemoteDataSource mockRemote;
  late EditProfileRepoImpl repo;
  setUpAll(() {
    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<GetLoggedDriverResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<VehiclesResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );

    provideDummy<ApiResult<EditProfileResponseDto>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<GetLoggedDriverResponseDto>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<UploadPhotoResponseDto>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<VehiclesResponseDto>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUpAll(() {
    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<GetLoggedDriverResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<VehiclesResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUp(() {
    mockRemote = MockEditProfileRemoteDataSource();
    repo = EditProfileRepoImpl(profileRemoteDataSource: mockRemote);
  });

  DriverDto buildDriverDto() {
    return DriverDto(
      id: '1',
      country: 'EG',
      firstName: 'A',
      lastName: 'B',
      vehicleType: 'Car',
      vehicleNumber: '111',
      vehicleLicense: 'LIC',
      NID: 'NID',
      NIDImg: 'img',
      email: 'a@b.com',
      gender: 'M',
      phone: '+201234567890',
      photo: 'ph',
      role: 'driver',
      createdAt: 'now',
    );
  }

  group('editProfile', () {
    test('returns success', () async {
      final reqEntity = EditProfileRequestEntity(
        firstName: 'A',
        lastName: 'B',
        email: 'a@b.com',
        phone: '+201234567890',
      );

      final respDto = EditProfileResponseDto(
        message: 'ok',
        driver: buildDriverDto(),
      );

      when(
        mockRemote.editProfile(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: respDto));

      final result = await repo.editProfile(reqEntity);

      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      verify(mockRemote.editProfile(any)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('returns error', () async {
      final reqEntity = EditProfileRequestEntity(
        firstName: 'A',
        lastName: 'B',
        email: 'a@b.com',
        phone: '+201234567890',
      );
      final failure = Failure(errorMessage: 'e');

      when(
        mockRemote.editProfile(any),
      ).thenAnswer((_) async => ApiErrorResult(failure: failure));

      final result = await repo.editProfile(reqEntity);
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
    });
  });

  group('getLoggedUserData', () {
    test('returns success', () async {
      final respDto = GetLoggedDriverResponseDto(
        message: 'ok',
        driver: buildDriverDto(),
      );

      when(
        mockRemote.getLoggedUserData(),
      ).thenAnswer((_) async => ApiSuccessResult(data: respDto));

      final result = await repo.getLoggedUserData();
      expect(result, isA<ApiSuccessResult<GetLoggedDriverResponseEntity>>());
    });

    test('returns error', () async {
      when(mockRemote.getLoggedUserData()).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.getLoggedUserData();
      expect(result, isA<ApiErrorResult<GetLoggedDriverResponseEntity>>());
    });
  });

  group('uploadProfilePhoto', () {
    test('returns success', () async {
      final file = File('test_assets/profile.jpg');
      final respDto = UploadPhotoResponseDto(message: 'ok');

      when(
        mockRemote.uploadProfilePhoto(file),
      ).thenAnswer((_) async => ApiSuccessResult(data: respDto));

      final result = await repo.uploadProfilePhoto(file);
      expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
    });

    test('returns error', () async {
      final file = File('test_assets/profile.jpg');
      when(mockRemote.uploadProfilePhoto(file)).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.uploadProfilePhoto(file);
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
    });
  });

  group('getVehicles', () {
    test('returns success', () async {
      final respDto = VehiclesResponseDto(
        message: 'ok',
        vehicles: [
          VehicleDto(
            id: 'v1',
            type: 'Car',
            image: 'i',
            createdAt: 'c',
            updatedAt: 'u',
            v: 0,
          ),
        ],
      );

      when(
        mockRemote.getVehicles(),
      ).thenAnswer((_) async => ApiSuccessResult(data: respDto));

      final result = await repo.getVehicles();
      expect(result, isA<ApiSuccessResult<VehiclesResponseEntity>>());
    });

    test('returns error', () async {
      when(mockRemote.getVehicles()).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.getVehicles();
      expect(result, isA<ApiErrorResult<VehiclesResponseEntity>>());
    });
  });

  group('updateVehicle', () {
    test('returns success', () async {
      final reqEntity = EditVehicleRequestEntity(
        vehicleNumber: '111',
        vehicleType: 'Car',
        vehicleLicense: 'LIC',
      );
      final respDto = EditProfileResponseDto(
        message: 'ok',
        driver: buildDriverDto(),
      );

      when(
        mockRemote.updateVehicle(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: respDto));

      final result = await repo.updateVehicle(reqEntity);
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
    });

    test('returns error', () async {
      final reqEntity = EditVehicleRequestEntity(
        vehicleNumber: '111',
        vehicleType: 'Car',
        vehicleLicense: 'LIC',
      );

      when(mockRemote.updateVehicle(any)).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.updateVehicle(reqEntity);
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
    });
  });
}
