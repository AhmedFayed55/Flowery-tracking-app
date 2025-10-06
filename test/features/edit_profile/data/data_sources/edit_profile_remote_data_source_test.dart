import 'dart:io';
import 'package:flowery_tracking_app/features/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/request/edit_vehicle_request_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/upload_photo_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/vehicle_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'edit_profile_remote_data_source_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  late MockEditProfileRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockEditProfileRemoteDataSource();
  });

  group('EditProfileRemoteDataSource', () {
    test('should call editProfile and return EditProfileResponseDto', () async {
      final request = EditProfileRequestModel(
        email: "a@b.com",
        firstName: "A",
        lastName: "B",
        phone: '01000000000',
      );

      final response = EditProfileResponseDto(
        message: 'Updated successfully',
        driver: DriverDto(
          id: "1",
          NID: "12345678901234",
          NIDImg: "nid_image.png",
          country: "Egypt",
          createdAt: "2025-01-01",
          email: "a@b.com",
          firstName: "A",
          gender: "Male",
          lastName: "B",
          phone: "01000000000",
          photo: "photo.png",
          role: "driver",
          vehicleLicense: "XYZ123",
          vehicleNumber: "5678",
          vehicleType: "Car",
          password: "password123",
        ),
      );

      when(
        mockDataSource.editProfile(request),
      ).thenAnswer((_) async => response);

      final result = await mockDataSource.editProfile(request);

      expect(result, isA<EditProfileResponseDto>());
      expect(result.message, equals('Updated successfully'));
      expect(result.driver.firstName, 'A');
      verify(mockDataSource.editProfile(request)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
      'should call getLoggedUserData and return GetLoggedDriverResponseDto',
      () async {
        final response = GetLoggedDriverResponseDto(
          message: 'Driver fetched',
          driver: DriverDto(
            id: "2",
            country: "Egypt",
            firstName: "Ahmed",
            lastName: "Rajeh",
            vehicleType: "Truck",
            vehicleNumber: "BS1234",
            vehicleLicense: "LIC1234",
            NID: "98765432109876",
            NIDImg: "nid_image.png",
            email: "ahmed@demo.com",
            gender: "Male",
            phone: "01111111111",
            photo: "profile.jpg",
            role: "driver",
            createdAt: "2025-01-01",
            password: "password123",
          ),
        );

        when(
          mockDataSource.getLoggedUserData(),
        ).thenAnswer((_) async => response);

        final result = await mockDataSource.getLoggedUserData();

        expect(result, isA<GetLoggedDriverResponseDto>());
        expect(result.message, equals('Driver fetched'));
        expect(result.driver.firstName, equals('Ahmed'));
        verify(mockDataSource.getLoggedUserData()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should call uploadProfilePhoto and return UploadPhotoResponseDto',
      () async {
        final mockFile = File('path/to/file.jpg');
        final response = UploadPhotoResponseDto(message: 'Photo uploaded');

        when(
          mockDataSource.uploadProfilePhoto(mockFile),
        ).thenAnswer((_) async => response);

        final result = await mockDataSource.uploadProfilePhoto(mockFile);

        expect(result, isA<UploadPhotoResponseDto>());
        expect(result.message, equals('Photo uploaded'));
        verify(mockDataSource.uploadProfilePhoto(mockFile)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('should call getVehicles and return VehiclesResponseDto', () async {
      final response = VehiclesResponseDto(
        message: 'Vehicles fetched',
        vehicles: [],
      );

      when(mockDataSource.getVehicles()).thenAnswer((_) async => response);

      final result = await mockDataSource.getVehicles();

      expect(result, isA<VehiclesResponseDto>());
      expect(result.message, equals('Vehicles fetched'));
      verify(mockDataSource.getVehicles()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test(
      'should call updateVehicle and return EditProfileResponseDto',
      () async {
        final request = EditVehicleRequestModel(
          vehicleNumber: '123',
          vehicleType: 'Car',
          vehicleLicense: 'ABC123',
        );

        final response = EditProfileResponseDto(
          message: 'Vehicle updated',
          driver: DriverDto(
            id: "3",
            country: "Egypt",
            firstName: "Ali",
            lastName: "Mostafa",
            vehicleType: "Car",
            vehicleNumber: "123",
            vehicleLicense: "ABC123",
            NID: "55566677788899",
            NIDImg: "nid.png",
            email: "ali@demo.com",
            gender: "Male",
            phone: "01098765432",
            photo: "photo.png",
            role: "driver",
            createdAt: "2025-01-01",
            password: "pass123",
          ),
        );

        when(
          mockDataSource.updateVehicle(request),
        ).thenAnswer((_) async => response);

        final result = await mockDataSource.updateVehicle(request);

        expect(result, isA<EditProfileResponseDto>());
        expect(result.message, equals('Vehicle updated'));
        expect(result.driver.vehicleNumber, equals('123'));
        verify(mockDataSource.updateVehicle(request)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
