import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds_impl.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/logout/logout_response_dto.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/response/profile_response_model.dart';
import 'package:flowery_tracking_app/features/main_profile/data/models/vehicle_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;
  late DriverDto driverDto;
  late VehicleDto vehicleDto;
  late ProfileResponseModel profileResponseModel;
  late LogoutResponseDto logoutResponseDto;

  setUpAll(() {
    mockApiServices = MockApiServices();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(
      apiServices: mockApiServices,
    );
    mockApiServices = MockApiServices();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(
      apiServices: mockApiServices,
    );

    driverDto = DriverDto(
      id: "1",
      email: "driver@example.com",
      phone: "0123456789",
    );

    profileResponseModel = ProfileResponseModel(
      message: "message",
      driverDto: driverDto,
    );

    vehicleDto = VehicleDto(id: "1");

    logoutResponseDto = LogoutResponseDto(message: "Logout successful");
  });

  group("Test ProfileRemoteDataSourceImpl in Data_Layer", () {
    test("success case for getProfile returns DriverDto", () async {
      // Arrange
      when(
        mockApiServices.getProfile(),
      ).thenAnswer((_) async => profileResponseModel);

      // // Act
      var result = await profileRemoteDataSourceImpl.getProfile();

      // // Assert
      expect(result, isA<DriverDto>());
      expect(result.id, equals(driverDto.id));
      expect(result.phone, equals(driverDto.phone));

      verify(mockApiServices.getProfile()).called(1);
    });

    test("success case for getVehicle returns VehicleDto", () async {
      // Arrange
      const vehicleType = "Car";
      when(
        mockApiServices.getVehicle(vehicleType),
      ).thenAnswer((_) async => vehicleDto);

      // Act
      var result = await profileRemoteDataSourceImpl.getVehicle(vehicleType);

      // Assert
      expect(result, isA<VehicleDto>());
      expect(result.id, equals(vehicleDto.id));
      expect(result.type, equals(vehicleDto.type));

      verify(mockApiServices.getVehicle(vehicleType)).called(1);
    });

    test("success case for logout returns LogoutResponseDto", () async {
      when(mockApiServices.logout()).thenAnswer((_) async => logoutResponseDto);

      var result = await profileRemoteDataSourceImpl.logout();

      expect(result, isA<LogoutResponseDto>());
      expect(result.message, equals("Logout successful"));

      verify(mockApiServices.logout()).called(1);
    });
  });
}
