import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/data_sources/edit_profile_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/response/vehicle_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/data/models/vehicle_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'edit_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late EditProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = EditProfileRemoteDataSourceImpl(
      profileApiService: mockApiServices,
    );
  });

  DriverDto buildDriverDto() {
    return DriverDto(
      id: '123abc',
      country: 'Egypt',
      firstName: 'Ahmed',
      lastName: 'Mohamed',
      vehicleType: 'Motorcycle',
      vehicleNumber: 'ABC-1234',
      vehicleLicense: 'LIC-789456',
      NID: '29501011234567',
      NIDImg: 'https://example.com/nid.jpg',
      email: 'ahmed.mohamed@example.com',
      gender: 'Male',
      phone: '+201234567890',
      photo: 'https://example.com/photo.jpg',
      role: 'driver',
      createdAt: '2024-10-01T10:30:00Z',
    );
  }

  group('editProfile', () {
    test('returns EditProfileResponseDto on success', () async {
      final dto = EditProfileResponseDto(
        message: 'ok',
        driver: buildDriverDto(),
      );
      final request = EditProfileRequestModel(
        firstName: 'Ahmed',
        lastName: 'Mohamed',
        email: 'ahmed.m@example.com',
        phone: '+201234567890',
      );

      when(mockApiServices.editProfile(any)).thenAnswer((_) async => dto);

      final result = await dataSource.editProfile(request);

      expect(result, isA<EditProfileResponseDto>());
      expect(result.message, 'ok');
      expect(result.driver.firstName, 'Ahmed');
    });

    test('throws DioException when API fails', () async {
      final request = EditProfileRequestModel(
        firstName: 'Ahmed',
        lastName: 'Mohamed',
        email: 'ahmed.m@example.com',
        phone: '+201234567890',
      );

      when(mockApiServices.editProfile(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/edit-profile')),
      );

      expect(
        () => dataSource.editProfile(request),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('getLoggedUserData', () {
    test('returns GetLoggedDriverResponseDto on success', () async {
      final dto = GetLoggedDriverResponseDto(
        message: 'ok',
        driver: buildDriverDto(),
      );

      when(mockApiServices.getLoggedUserData()).thenAnswer((_) async => dto);

      final result = await dataSource.getLoggedUserData();
      expect(result, isA<GetLoggedDriverResponseDto>());
      expect(result.driver.id, '123abc');
    });

    test('throws DioException when API fails', () async {
      when(
        mockApiServices.getLoggedUserData(),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/me')));

      expect(
        () => dataSource.getLoggedUserData(),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('uploadProfilePhoto', () {
    test('returns UploadPhotoResponseDto on success', () async {
      final dto = UploadPhotoResponseDto(message: 'uploaded');
      final file = File('test_assets/profile.jpg');

      when(
        mockApiServices.uploadProfilePhoto(any),
      ).thenAnswer((_) async => dto);

      final result = await dataSource.uploadProfilePhoto(file);
      expect(result, isA<UploadPhotoResponseDto>());
      expect(result.message, 'uploaded');
    });

    test('throws DioException when API fails', () async {
      final file = File('test_assets/profile.jpg');

      when(mockApiServices.uploadProfilePhoto(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/upload')),
      );

      expect(
        () => dataSource.uploadProfilePhoto(file),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('getVehicles', () {
    test('returns VehiclesResponseDto on success', () async {
      final dto = VehiclesResponseDto(
        message: 'ok',
        vehicles: [
          VehicleDto(
            id: 'v1',
            type: 'Car',
            image: 'img',
            createdAt: 'c',
            updatedAt: 'u',
            v: 0,
          ),
          VehicleDto(
            id: 'v2',
            type: 'Bike',
            image: 'img2',
            createdAt: 'c',
            updatedAt: 'u',
            v: 0,
          ),
        ],
      );

      when(mockApiServices.getAllVehicles()).thenAnswer((_) async => dto);

      final result = await dataSource.getVehicles();
      expect(result, isA<VehiclesResponseDto>());
      expect(result.vehicles.length, 2);
      expect(result.vehicles.first.type, 'Car');
    });

    test('throws DioException when API fails', () async {
      when(mockApiServices.getAllVehicles()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/vehicles')),
      );

      expect(() => dataSource.getVehicles(), throwsA(isA<DioException>()));
    });
  });

  group('updateVehicle', () {
    test('returns EditProfileResponseDto on success', () async {
      final dto = EditProfileResponseDto(
        message: 'updated',
        driver: buildDriverDto(),
      );
      final request = EditVehicleRequestModel(
        vehicleNumber: 'XYZ-5678',
        vehicleType: 'Car',
        vehicleLicense: 'LIC-112233',
      );

      when(mockApiServices.updateVehicle(any)).thenAnswer((_) async => dto);

      final result = await dataSource.updateVehicle(request);
      expect(result, isA<EditProfileResponseDto>());
      expect(result.message, 'updated');
    });

    test('throws DioException when API fails', () async {
      final request = EditVehicleRequestModel(
        vehicleNumber: 'XYZ-5678',
        vehicleType: 'Car',
        vehicleLicense: 'LIC-112233',
      );

      when(mockApiServices.updateVehicle(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/edit-vehicle')),
      );

      expect(
        () => dataSource.updateVehicle(request),
        throwsA(isA<DioException>()),
      );
    });
  });
}
