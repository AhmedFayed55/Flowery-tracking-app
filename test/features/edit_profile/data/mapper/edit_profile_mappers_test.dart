import 'package:flowery_tracking_app/features/edit_profile/data/mapper/edit_profile_mappers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/edit_profile_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/data/models/response/get_logged_driver_response_dto.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';

void main() {
  group('EditProfile Mapper Tests', () {
    final mockDriverDto = DriverDto(
      id: '1',
      country: 'Egypt',
      firstName: 'Ahmed',
      lastName: 'Rajeh',
      vehicleType: 'Car',
      vehicleNumber: '1234',
      vehicleLicense: 'ABC123',
      NID: '29812345678901',
      NIDImg: 'nid_image.png',
      email: 'ahmed@example.com',
      password: 'password123',
      gender: 'Male',
      phone: '01012345678',
      photo: 'driver_photo.png',
      role: 'Driver',
      createdAt: '2025-10-05',
    );

    test('DriverDto ΓåÆ DriverEntity mapping should be correct', () {
      final result = mockDriverDto.toEntity();

      expect(result.id, mockDriverDto.id);
      expect(result.country, mockDriverDto.country);
      expect(result.firstName, mockDriverDto.firstName);
      expect(result.lastName, mockDriverDto.lastName);
      expect(result.vehicleType, mockDriverDto.vehicleType);
      expect(result.vehicleNumber, mockDriverDto.vehicleNumber);
      expect(result.vehicleLicense, mockDriverDto.vehicleLicense);
      expect(result.NID, mockDriverDto.NID);
      expect(result.NIDImg, mockDriverDto.NIDImg);
      expect(result.email, mockDriverDto.email);
      expect(result.password, mockDriverDto.password);
      expect(result.gender, mockDriverDto.gender);
      expect(result.phone, mockDriverDto.phone);
      expect(result.photo, mockDriverDto.photo);
      expect(result.role, mockDriverDto.role);
      expect(result.createdAt, mockDriverDto.createdAt);
    });

    test(
      'EditProfileRequestEntity ΓåÆ EditProfileRequestModel mapping should be correct',
      () {
        final mockEntity = EditProfileRequestEntity(
          firstName: 'Ahmed',
          lastName: 'Rajeh',
          email: 'ahmed@example.com',
          phone: '01012345678',
        );

        final result = mockEntity.toModel();

        expect(result.firstName, mockEntity.firstName);
        expect(result.lastName, mockEntity.lastName);
        expect(result.email, mockEntity.email);
        expect(result.phone, mockEntity.phone);
      },
    );

    test(
      'EditProfileResponseDto ΓåÆ EditProfileResponseEntity mapping should be correct',
      () {
        final mockResponseDto = EditProfileResponseDto(
          message: 'Profile updated successfully',
          driver: mockDriverDto,
        );

        final result = mockResponseDto.toEntity();

        expect(result.message, mockResponseDto.message);
        expect(result.driver.firstName, mockResponseDto.driver.firstName);
        expect(result.driver.id, mockResponseDto.driver.id);
      },
    );

    test(
      'GetLoggedDriverResponseDto ΓåÆ GetLoggedDriverResponseEntity mapping should be correct',
      () {
        final mockGetLoggedDriverResponseDto = GetLoggedDriverResponseDto(
          message: 'Driver fetched successfully',
          driver: mockDriverDto,
        );

        final result = mockGetLoggedDriverResponseDto.toEntity();

        expect(result.message, mockGetLoggedDriverResponseDto.message);
        expect(
          result.driver.email,
          mockGetLoggedDriverResponseDto.driver.email,
        );
        expect(
          result.driver.phone,
          mockGetLoggedDriverResponseDto.driver.phone,
        );
      },
    );
  });
}
