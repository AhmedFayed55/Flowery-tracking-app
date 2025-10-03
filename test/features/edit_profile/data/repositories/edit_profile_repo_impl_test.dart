import 'dart:io';

import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/repositories/edit_profile_repo_impl.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';
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
  });

  setUp(() {
    mockRemote = MockEditProfileRemoteDataSource();
    repo = EditProfileRepoImpl(profileRemoteDataSource: mockRemote);
  });

  group('editProfile', () {
    test('returns success', () async {
      final req = EditProfileRequestEntity(
        firstName: 'A',
        lastName: 'B',
        email: 'a@b.com',
        phone: '+201234567890',
      );
      final resp = EditProfileResponseEntity(
        message: 'ok',
        driver: DriverEntity(
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
          password: 'p',
          gender: 'M',
          phone: '+201234567890',
          photo: 'ph',
          role: 'driver',
          createdAt: 'now',
        ),
      );

      when(
        mockRemote.editProfile(req),
      ).thenAnswer((_) async => ApiSuccessResult(data: resp));

      final result = await repo.editProfile(req);
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      verify(mockRemote.editProfile(req)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('returns error', () async {
      final req = EditProfileRequestEntity(
        firstName: 'A',
        lastName: 'B',
        email: 'a@b.com',
        phone: '+201234567890',
      );
      final failure = Failure(errorMessage: 'e');

      when(
        mockRemote.editProfile(req),
      ).thenAnswer((_) async => ApiErrorResult(failure: failure));

      final result = await repo.editProfile(req);
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockRemote.editProfile(req)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });

  group('getLoggedUserData', () {
    test('returns success', () async {
      final resp = GetLoggedDriverResponseEntity(
        message: 'ok',
        driver: DriverEntity(
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
          password: 'p',
          gender: 'M',
          phone: '+201234567890',
          photo: 'ph',
          role: 'driver',
          createdAt: 'now',
        ),
      );

      when(
        mockRemote.getLoggedUserData(),
      ).thenAnswer((_) async => ApiSuccessResult(data: resp));

      final result = await repo.getLoggedUserData();
      expect(result, isA<ApiSuccessResult<GetLoggedDriverResponseEntity>>());
      verify(mockRemote.getLoggedUserData()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('returns error', () async {
      when(mockRemote.getLoggedUserData()).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.getLoggedUserData();
      expect(result, isA<ApiErrorResult<GetLoggedDriverResponseEntity>>());
      verify(mockRemote.getLoggedUserData()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });

  group('uploadProfilePhoto', () {
    test('returns success', () async {
      final file = File('test_assets/profile.jpg');
      final resp = UploadPhotoResponseEntity(message: 'ok');

      when(
        mockRemote.uploadProfilePhoto(file),
      ).thenAnswer((_) async => ApiSuccessResult(data: resp));

      final result = await repo.uploadProfilePhoto(file);
      expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
      verify(mockRemote.uploadProfilePhoto(file)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('returns error', () async {
      final file = File('test_assets/profile.jpg');
      when(mockRemote.uploadProfilePhoto(file)).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.uploadProfilePhoto(file);
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockRemote.uploadProfilePhoto(file)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });

  group('getVehicles', () {
    test('returns success', () async {
      final resp = VehiclesResponseEntity(
        message: 'ok',
        vehicles: [VehicleEntity(id: 'v1', type: 'Car', image: 'i')],
      );

      when(
        mockRemote.getVehicles(),
      ).thenAnswer((_) async => ApiSuccessResult(data: resp));

      final result = await repo.getVehicles();
      expect(result, isA<ApiSuccessResult<VehiclesResponseEntity>>());
      verify(mockRemote.getVehicles()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('returns error', () async {
      when(mockRemote.getVehicles()).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.getVehicles();
      expect(result, isA<ApiErrorResult<VehiclesResponseEntity>>());
      verify(mockRemote.getVehicles()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });

  group('updateVehicle', () {
    test('returns success', () async {
      final req = EditVehicleRequestEntity(
        vehicleNumber: '111',
        vehicleType: 'Car',
        vehicleLicense: 'LIC',
      );
      final resp = EditProfileResponseEntity(
        message: 'ok',
        driver: DriverEntity(
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
          password: 'p',
          gender: 'M',
          phone: '+201234567890',
          photo: 'ph',
          role: 'driver',
          createdAt: 'now',
        ),
      );

      when(
        mockRemote.updateVehicle(req),
      ).thenAnswer((_) async => ApiSuccessResult(data: resp));

      final result = await repo.updateVehicle(req);
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      verify(mockRemote.updateVehicle(req)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('returns error', () async {
      final req = EditVehicleRequestEntity(
        vehicleNumber: '111',
        vehicleType: 'Car',
        vehicleLicense: 'LIC',
      );

      when(mockRemote.updateVehicle(req)).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'e')),
      );

      final result = await repo.updateVehicle(req);
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockRemote.updateVehicle(req)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}
